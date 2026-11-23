<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ApiToken;
use App\Models\MovimientoInventario;
use App\Models\Producto;
use App\Models\SyncEvent;
use App\Models\User;
use App\Models\Venta;
use App\Models\VentaDetalle;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class TiendaGoApiController extends Controller
{
    public function token(Request $request): JsonResponse
    {
        $data = Validator::make($request->all(), [
            'email' => ['required', 'email'],
            'password' => ['required', 'string'],
        ])->validate();

        $user = User::where('email', mb_strtolower(trim($data['email'])))->first();
        if (!$user || !$user->activo || !Hash::check($data['password'], $user->password)) {
            return response()->json(['detail' => 'Correo o contraseña incorrectos.'], 401);
        }

        if (!$user->empresa || !$user->empresa->tieneAccesoVigente()) {
            return response()->json(['detail' => 'La tienda no tiene una suscripción vigente.'], 403);
        }

        return response()->json($this->issueTokenPair($user));
    }

    public function refresh(Request $request): JsonResponse
    {
        $data = Validator::make($request->all(), [
            'refresh' => ['required', 'string'],
        ])->validate();

        return DB::transaction(function () use ($data) {
            $token = ApiToken::with('user.empresa')
                ->where('token_hash', hash('sha256', $data['refresh']))
                ->where('type', 'refresh')
                ->where('expires_at', '>', now())
                ->lockForUpdate()
                ->first();
            $user = $token?->user;
            if (!$user || !$user->activo || !$user->empresa || !$user->empresa->tieneAccesoVigente()) {
                return response()->json(['detail' => 'El token de renovación no es válido.'], 401);
            }

            $token->delete();

            return response()->json($this->issueTokenPair($user));
        });
    }

    public function store(Request $request): JsonResponse
    {
        $empresa = $request->user()->empresa;

        return response()->json([
            'results' => [[
                'id' => (string) $empresa->id,
                'name' => $empresa->nombre_comercial ?: $empresa->razon_social,
                'slug' => (string) $empresa->slug,
            ]],
        ]);
    }

    public function products(Request $request): JsonResponse
    {
        $products = Producto::where('activo', true)
            ->orderBy('nombre')
            ->paginate(min(max($request->integer('page_size', 100), 1), 100));

        return response()->json([
            'results' => $products->getCollection()->map(fn (Producto $product) => $this->productData($product)),
            'next' => $products->hasMorePages() ? $products->currentPage() + 1 : null,
            'previous' => $products->currentPage() > 1 ? $products->currentPage() - 1 : null,
        ]);
    }

    public function orders(Request $request): JsonResponse
    {
        $orders = Venta::with('detalles.producto')
            ->orderByDesc('fecha_venta')
            ->paginate(min(max($request->integer('page_size', 100), 1), 100));

        return response()->json([
            'results' => $orders->getCollection()->map(function (Venta $sale) {
                return [
                    'id' => (string) $sale->id,
                    'client_event_id' => $sale->sync_event_id,
                    'total' => (string) $sale->total,
                    'payment_method' => $sale->forma_pago === 'efectivo' ? 'cash' : 'manual',
                    'created_at' => $sale->fecha_venta?->toISOString(),
                    'lines' => $sale->detalles->map(fn (VentaDetalle $line) => [
                        'product_id' => (string) $line->producto?->sync_id,
                        'product_name' => $line->descripcion,
                        'quantity' => (int) $line->cantidad,
                        'unit_price' => (string) $line->precio_unitario,
                    ]),
                ];
            }),
            'next' => $orders->hasMorePages() ? $orders->currentPage() + 1 : null,
        ]);
    }

    public function sync(Request $request): JsonResponse
    {
        $events = $request->input('events');
        if (!is_array($events) || count($events) < 1 || count($events) > 100) {
            return response()->json([
                'detail' => 'events debe contener entre 1 y 100 operaciones.',
            ], 422);
        }

        $results = [];
        foreach ($events as $rawEvent) {
            if (!is_array($rawEvent)) {
                $results[] = ['status' => 'invalid', 'errors' => ['event' => ['Formato inválido.']]];
                continue;
            }

            $validator = Validator::make($rawEvent, [
                'id' => ['required', 'uuid'],
                'type' => ['required', 'in:sale,product_upsert'],
                'payload' => ['required', 'array'],
            ]);
            if ($validator->fails()) {
                $results[] = [
                    'id' => $rawEvent['id'] ?? null,
                    'status' => 'invalid',
                    'errors' => $validator->errors(),
                ];
                continue;
            }

            try {
                $results[] = DB::transaction(fn () => $this->processEvent(
                    (int) $request->user()->empresa_id,
                    $request->user(),
                    $rawEvent
                ));
            } catch (SyncConflict $conflict) {
                $results[] = [
                    'id' => $rawEvent['id'],
                    'status' => 'conflict',
                    'detail' => $conflict->getMessage(),
                ];
            } catch (QueryException $error) {
                if (($error->errorInfo[0] ?? null) !== '23000') {
                    throw $error;
                }

                $existing = SyncEvent::where('event_id', $rawEvent['id'])->first();
                $results[] = $existing && (int) $existing->empresa_id === (int) $request->user()->empresa_id
                    ? ['id' => $rawEvent['id'], 'status' => 'duplicate', 'result' => $existing->result]
                    : [
                        'id' => $rawEvent['id'],
                        'status' => 'conflict',
                        'detail' => 'No se pudo aplicar la operación; revisa el estado de la tienda.',
                    ];
            }
        }

        return response()->json(['results' => $results]);
    }

    private function issueTokenPair(User $user): array
    {
        ApiToken::where('user_id', $user->id)->where('expires_at', '<=', now())->delete();
        $access = Str::random(64);
        $refresh = Str::random(80);

        ApiToken::create([
            'user_id' => $user->id,
            'token_hash' => hash('sha256', $access),
            'type' => 'access',
            'expires_at' => now()->addMinutes(15),
        ]);
        ApiToken::create([
            'user_id' => $user->id,
            'token_hash' => hash('sha256', $refresh),
            'type' => 'refresh',
            'expires_at' => now()->addDays(30),
        ]);

        return ['access' => $access, 'refresh' => $refresh];
    }

    private function processEvent(int $empresaId, User $user, array $event): array
    {
        $existing = SyncEvent::where('event_id', $event['id'])->first();
        if ($existing) {
            if ((int) $existing->empresa_id !== $empresaId) {
                throw new SyncConflict('El identificador ya pertenece a otra tienda.');
            }

            return ['id' => $event['id'], 'status' => 'duplicate', 'result' => $existing->result];
        }

        if ($event['type'] === 'product_upsert') {
            return $this->processProductUpsert($empresaId, $event);
        }

        return $this->processSale($empresaId, $user, $event);
    }

    private function processProductUpsert(int $empresaId, array $event): array
    {
        $data = Validator::make($event['payload'], [
            'product_id' => ['required', 'uuid'],
            'base_version' => ['required', 'integer', 'min:0'],
            'name' => ['required', 'string', 'max:160'],
            'sku' => ['required', 'string', 'max:64'],
            'price' => ['required', 'numeric', 'min:0', 'max:9999999999.99'],
            'stock' => ['required', 'integer', 'min:0', 'max:999999999'],
        ])->validate();

        $productId = strtolower($data['product_id']);
        $product = Producto::where('sync_id', $productId)->lockForUpdate()->first();
        if (!$product) {
            if (Producto::withoutGlobalScopes()->where('sync_id', $productId)->exists()) {
                throw new SyncConflict('El producto pertenece a otra tienda.');
            }
            if ($data['base_version'] !== 0) {
                throw new SyncConflict('El producto cambió antes de poder sincronizarse.');
            }
            $sku = mb_strtoupper(trim($data['sku']));
            if (Producto::where('codigo', $sku)->exists()) {
                throw new SyncConflict('El código ya está asignado a otro producto.');
            }
            $product = Producto::create([
                'sync_id' => $productId,
                'sync_version' => 1,
                'codigo' => $sku,
                'nombre' => trim($data['name']),
                'unidad_medida' => 'UND',
                'precio_venta' => $data['price'],
                'stock' => $data['stock'],
                'activo' => true,
                'controla_stock' => true,
                'aplica_impuesto' => true,
            ]);
        } else {
            if ((int) $product->sync_version !== (int) $data['base_version']) {
                throw new SyncConflict('Conflicto de edición; vuelve a sincronizar el producto.');
            }

            $sku = mb_strtoupper(trim($data['sku']));
            if (Producto::where('codigo', $sku)->where('id', '<>', $product->id)->exists()) {
                throw new SyncConflict('El código ya está asignado a otro producto.');
            }

            $product->codigo = $sku;
            $product->nombre = trim($data['name']);
            $product->precio_venta = $data['price'];
            $product->stock = $data['stock'];
            $product->activo = true;
            $product->sync_version = (int) $product->sync_version + 1;
            $product->save();
        }

        $result = $this->productData($product);
        SyncEvent::create([
            'event_id' => $event['id'],
            'empresa_id' => $empresaId,
            'event_type' => 'product_upsert',
            'result' => $result,
        ]);

        return ['id' => $event['id'], 'status' => 'created', 'result' => $result];
    }

    private function processSale(int $empresaId, User $user, array $event): array
    {
        $data = Validator::make($event['payload'], [
            'payment_method' => ['sometimes', 'in:cash,manual'],
            'lines' => ['required', 'array', 'min:1', 'max:100'],
            'lines.*.product_id' => ['required', 'uuid'],
            'lines.*.quantity' => ['required', 'integer', 'min:1', 'max:100000'],
        ])->validate();
        $lineIds = array_map(fn ($line) => strtolower($line['product_id']), $data['lines']);
        if (count(array_unique($lineIds)) !== count($lineIds)) {
            throw new SyncConflict('No repitas productos en una misma venta.');
        }

        $products = Producto::whereIn('sync_id', $lineIds)
            ->orderBy('id')
            ->lockForUpdate()
            ->get()
            ->keyBy('sync_id');
        if ($products->count() !== count($lineIds)) {
            throw new SyncConflict('Uno o más productos ya no están disponibles en esta tienda.');
        }

        $totalCents = 0;
        $maximumTotalCents = 999999999999;
        foreach ($data['lines'] as $line) {
            $product = $products->get(strtolower($line['product_id']));
            if (!$product->activo) {
                throw new SyncConflict('Uno o más productos ya no están activos.');
            }
            if ($product->controla_stock && (float) $product->stock < (int) $line['quantity']) {
                throw new SyncConflict('No hay existencias suficientes para sincronizar la venta.');
            }
            $unitCents = (int) round((float) $product->precio_venta * 100);
            $quantity = (int) $line['quantity'];
            if (
                ($unitCents > 0 && $quantity > intdiv($maximumTotalCents, $unitCents))
                || $totalCents > $maximumTotalCents - ($unitCents * $quantity)
            ) {
                throw new SyncConflict('El total de la venta supera el máximo permitido.');
            }
            $totalCents += $unitCents * $quantity;
        }
        $total = number_format($totalCents / 100, 2, '.', '');
        $ticket = 'O-' . strtoupper(substr(str_replace('-', '', $event['id']), 0, 28));
        $sale = Venta::create([
            'sync_event_id' => $event['id'],
            'numero_ticket' => $ticket,
            'tipo_comprobante' => 'TICKET',
            'serie' => 'OFF',
            'fecha_venta' => now(),
            'user_id' => $user->id,
            'turno_caja_id' => null,
            'subtotal' => $total,
            'descuento' => 0,
            'impuesto' => 0,
            'total' => $total,
            'monto_recibido' => $total,
            'cambio' => 0,
            'forma_pago' => $data['payment_method'] ?? 'cash',
            'estado' => 'completada',
            'observaciones' => 'Sincronizada desde el punto de venta local.',
        ]);

        foreach ($data['lines'] as $line) {
            $product = $products->get(strtolower($line['product_id']));
            $quantity = (int) $line['quantity'];
            $unitPrice = (float) $product->precio_venta;
            $lineTotal = number_format((int) round($unitPrice * 100) * $quantity / 100, 2, '.', '');
            VentaDetalle::create([
                'venta_id' => $sale->id,
                'producto_id' => $product->id,
                'codigo' => $product->codigo,
                'descripcion' => $product->nombre,
                'cantidad' => $quantity,
                'precio_unitario' => $product->precio_venta,
                'descuento' => 0,
                'impuesto' => 0,
                'subtotal' => $lineTotal,
                'total' => $lineTotal,
            ]);

            if ($product->controla_stock) {
                $previousStock = (float) $product->stock;
                $product->stock = $previousStock - $quantity;
                $product->sync_version = (int) $product->sync_version + 1;
                $product->save();

                MovimientoInventario::create([
                    'producto_id' => $product->id,
                    'user_id' => $user->id,
                    'tipo' => 'salida',
                    'motivo' => 'Venta offline sincronizada #' . $ticket,
                    'cantidad' => $quantity,
                    'stock_anterior' => $previousStock,
                    'stock_nuevo' => $product->stock,
                    'referencia_tipo' => 'venta',
                    'referencia_id' => $sale->id,
                    'fecha' => now(),
                ]);
            }
        }

        $result = [
            'order_id' => (string) $sale->id,
            'total' => $total,
            'products' => $products->values()->map(fn (Producto $product) => [
                'id' => (string) $product->sync_id,
                'version' => (int) $product->sync_version,
                'stock' => (int) $product->stock,
            ])->all(),
        ];
        SyncEvent::create([
            'event_id' => $event['id'],
            'empresa_id' => $empresaId,
            'event_type' => 'sale',
            'result' => $result,
        ]);

        return ['id' => $event['id'], 'status' => 'created', 'result' => $result];
    }

    private function productData(Producto $product): array
    {
        return [
            'id' => (string) $product->sync_id,
            'name' => $product->nombre,
            'sku' => $product->codigo,
            'price' => (string) $product->precio_venta,
            'stock' => (int) $product->stock,
            'version' => (int) $product->sync_version,
            'updated_at' => $product->updated_at?->toISOString(),
        ];
    }
}

class SyncConflict extends \RuntimeException
{
}
