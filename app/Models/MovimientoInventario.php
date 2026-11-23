<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MovimientoInventario extends Model
{
    use BelongsToEmpresa;

    protected $table = 'movimientos_inventario';

    protected $fillable = [
        'empresa_id',
        'producto_id',
        'user_id',
        'tipo',
        'motivo',
        'cantidad',
        'stock_anterior',
        'stock_nuevo',
        'referencia_tipo',
        'referencia_id',
        'observaciones',
        'fecha',
    ];

    protected function casts(): array
    {
        return [
            'cantidad' => 'decimal:3',
            'stock_anterior' => 'decimal:3',
            'stock_nuevo' => 'decimal:3',
            'fecha' => 'datetime',
        ];
    }

    public function producto(): BelongsTo
    {
        return $this->belongsTo(Producto::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}