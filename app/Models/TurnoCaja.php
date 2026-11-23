<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TurnoCaja extends Model
{
    use BelongsToEmpresa;

    protected $table = 'turnos_caja';

    protected $fillable = [
        'empresa_id',
        'caja_id',
        'user_id',
        'fecha_apertura',
        'fecha_cierre',
        'monto_apertura',
        'monto_cierre',
        'monto_calculado',
        'diferencia',
        'total_ventas',
        'total_efectivo',
        'total_tarjeta',
        'total_otros',
        'cantidad_ventas',
        'observaciones',
        'estado',
    ];

    protected function casts(): array
    {
        return [
            'fecha_apertura' => 'datetime',
            'fecha_cierre' => 'datetime',
            'monto_apertura' => 'decimal:2',
            'monto_cierre' => 'decimal:2',
            'monto_calculado' => 'decimal:2',
            'diferencia' => 'decimal:2',
            'total_ventas' => 'decimal:2',
            'total_efectivo' => 'decimal:2',
            'total_tarjeta' => 'decimal:2',
            'total_otros' => 'decimal:2',
            'cantidad_ventas' => 'integer',
        ];
    }

    public function caja(): BelongsTo
    {
        return $this->belongsTo(Caja::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function movimientos(): HasMany
    {
        return $this->hasMany(MovimientoCaja::class, 'turno_caja_id');
    }

    public function ventas(): HasMany
    {
        return $this->hasMany(Venta::class, 'turno_caja_id');
    }
}