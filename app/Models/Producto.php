<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Str;

class Producto extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'codigo',
        'codigo_barras',
        'nombre',
        'descripcion',
        'categoria_id',
        'proveedor_id',
        'unidad_medida',
        'precio_compra',
        'precio_venta',
        'precio_mayoreo',
        'cantidad_mayoreo',
        'stock',
        'stock_minimo',
        'stock_maximo',
        'controla_stock',
        'aplica_impuesto',
        'imagen',
        'fecha_vencimiento',
        'lote',
        'ubicacion',
        'activo',
        'destacado',
        'sync_id',
        'sync_version',
    ];

    protected function casts(): array
    {
        return [
            'precio_compra' => 'decimal:2',
            'precio_venta' => 'decimal:2',
            'precio_mayoreo' => 'decimal:2',
            'cantidad_mayoreo' => 'integer',
            'stock' => 'decimal:3',
            'stock_minimo' => 'decimal:3',
            'stock_maximo' => 'decimal:3',
            'controla_stock' => 'boolean',
            'aplica_impuesto' => 'boolean',
            'fecha_vencimiento' => 'date',
            'activo' => 'boolean',
            'destacado' => 'boolean',
        ];
    }

    protected static function booted(): void
    {
        static::creating(function (Producto $producto) {
            if (!$producto->sync_id) {
                $producto->sync_id = (string) Str::uuid();
            }
            if (!$producto->sync_version) {
                $producto->sync_version = 1;
            }
        });

        static::updating(function (Producto $producto) {
            $syncFields = ['codigo', 'nombre', 'precio_venta', 'stock', 'activo'];
            if ($producto->isDirty($syncFields) && !$producto->isDirty('sync_version')) {
                $producto->sync_version = (int) $producto->getOriginal('sync_version') + 1;
            }
        });
    }

    public function categoria(): BelongsTo
    {
        return $this->belongsTo(Categoria::class);
    }

    public function proveedor(): BelongsTo
    {
        return $this->belongsTo(Proveedor::class);
    }

    public function movimientos(): HasMany
    {
        return $this->hasMany(MovimientoInventario::class);
    }

    public function detallesVenta(): HasMany
    {
        return $this->hasMany(VentaDetalle::class);
    }
}