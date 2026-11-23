<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Compra extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'numero',
        'numero_factura',
        'proveedor_id',
        'user_id',
        'fecha_compra',
        'fecha_vencimiento',
        'subtotal',
        'impuesto',
        'descuento',
        'total',
        'forma_pago',
        'estado',
        'observaciones',
    ];

    protected function casts(): array
    {
        return [
            'fecha_compra' => 'datetime',
            'fecha_vencimiento' => 'date',
            'subtotal' => 'decimal:2',
            'impuesto' => 'decimal:2',
            'descuento' => 'decimal:2',
            'total' => 'decimal:2',
        ];
    }

    public function proveedor(): BelongsTo
    {
        return $this->belongsTo(Proveedor::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function detalles(): HasMany
    {
        return $this->hasMany(CompraDetalle::class);
    }
}