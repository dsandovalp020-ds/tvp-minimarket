<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Caja;
use App\Models\Categoria;
use App\Models\Configuracion;
use App\Models\Empresa;
use App\Models\Role;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class TenantRegisterController extends Controller
{
    public function create()
    {
        return view('saas.register');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'razon_social'     => 'required|string|max:255',
            'nombre_comercial' => 'nullable|string|max:255',
            'ruc_nit'          => 'nullable|string|max:30',
            'moneda'           => 'nullable|string|max:10',
            'codigo_moneda'    => 'nullable|string|max:5',
            'name'             => 'required|string|max:255',
            'username'         => 'required|string|max:50|unique:users,username',
            'email'            => 'required|email|unique:users,email',
            'password'         => 'required|string|min:8|confirmed',
        ]);

        $monedas = [
            'COP' => '$',
            'PEN' => 'S/',
            'USD' => '$',
            'MXN' => '$',
        ];
        $codigoMoneda = $validated['codigo_moneda'] ?? 'COP';
        $simboloMoneda = $validated['moneda'] ?? ($monedas[$codigoMoneda] ?? '$');
        $adminRole = Role::firstOrCreate(
            ['nombre' => 'Administrador'],
            [
                'descripcion' => 'Acceso completo al sistema',
                'permisos' => ['*'],
                'activo' => true,
            ]
        );

        $user = DB::transaction(function () use ($validated, $codigoMoneda, $simboloMoneda, $adminRole) {
            // 1. Crear la Empresa (Tenant) con 14 días de prueba
            $empresa = Empresa::create([
                'razon_social'      => $validated['razon_social'],
                'nombre_comercial'  => $validated['nombre_comercial'] ?? $validated['razon_social'],
                'slug'              => Str::slug($validated['razon_social']) . '-' . Str::random(4),
                'ruc_nit'           => $validated['ruc_nit'] ?? null,
                'moneda'            => $simboloMoneda,
                'codigo_moneda'     => $codigoMoneda,
                'impuesto'          => 19.00,
                'impuesto_incluido' => true,
                'mensaje_ticket'    => '¡Gracias por su compra! Vuelva pronto.',
                'plan'              => 'trial',
                'trial_hasta'       => now()->addDays(14),
                'activo'            => true,
            ]);

            // 2. Crear usuario Administrador de la tienda
            $user = User::create([
                'empresa_id' => $empresa->id,
                'role_id'    => $adminRole->id,
                'name'       => $validated['name'],
                'username'   => $validated['username'],
                'email'      => $validated['email'],
                'password'   => Hash::make($validated['password']),
                'activo'     => true,
            ]);

            // 3. Crear Caja Principal por defecto
            Caja::create([
                'empresa_id'  => $empresa->id,
                'nombre'      => 'Caja Principal',
                'descripcion' => 'Caja principal del punto de venta',
                'activo'      => true,
            ]);

            // 4. Crear categoría inicial
            Categoria::create([
                'empresa_id'  => $empresa->id,
                'nombre'      => 'General',
                'descripcion' => 'Productos generales',
                'color'       => '#3B82F6',
                'icono'       => 'cube',
                'activo'      => true,
            ]);

            // 5. Inicializar parámetros de configuración base del POS
            $configs = [
                ['clave' => 'puntos_por_moneda',      'valor' => '0.1',  'tipo' => 'string',  'grupo' => 'fidelidad'],
                ['clave' => 'dias_aviso_vencimiento', 'valor' => '30',   'tipo' => 'integer', 'grupo' => 'inventario'],
                ['clave' => 'stock_minimo_default',   'valor' => '5',    'tipo' => 'integer', 'grupo' => 'inventario'],
                ['clave' => 'serie_ticket',           'valor' => 'T001', 'tipo' => 'string',  'grupo' => 'facturacion'],
                ['clave' => 'serie_boleta',           'valor' => 'B001', 'tipo' => 'string',  'grupo' => 'facturacion'],
                ['clave' => 'serie_factura',          'valor' => 'F001', 'tipo' => 'string',  'grupo' => 'facturacion'],
                ['clave' => 'ancho_ticket',           'valor' => '80',   'tipo' => 'integer', 'grupo' => 'ticket'],
                ['clave' => 'imprimir_auto',          'valor' => '1',    'tipo' => 'boolean', 'grupo' => 'ticket'],
                ['clave' => 'mostrar_logo_ticket',    'valor' => '1',    'tipo' => 'boolean', 'grupo' => 'ticket'],
            ];

            foreach ($configs as $cfg) {
                Configuracion::create(array_merge($cfg, ['empresa_id' => $empresa->id]));
            }

            return $user;
        });

        Auth::login($user);

        return redirect()->route('dashboard');
    }
}
