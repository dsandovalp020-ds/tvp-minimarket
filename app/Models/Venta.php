<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Venta extends Model
{
    use BelongsToEmpresa;

    protected $table = 'ventas';

    protected $fillable = [
        'empresa_id',
        'numero_ticket',
        'sync_event_id',
        'tipo_comprobante',
        'serie',
        'fecha_venta',
        'cliente_id',
        'user_id',
        'turno_caja_id',
        'subtotal',
        'descuento',
        'impuesto',
        'total',
        'monto_recibido',
        'cambio',
        'forma_pago',
        'detalle_pago',
        'estado',
        'observaciones',
    ];

    protected function casts(): array
    {
        return [
            'fecha_venta' => 'datetime',
            'subtotal' => 'decimal:2',
            'descuento' => 'decimal:2',
            'impuesto' => 'decimal:2',
            'total' => 'decimal:2',
            'monto_recibido' => 'decimal:2',
            'cambio' => 'decimal:2',
            'detalle_pago' => 'array',
        ];
    }

    public function cliente(): BelongsTo
    {
        return $this->belongsTo(Cliente::class);
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function turnoCaja(): BelongsTo
    {
        return $this->belongsTo(TurnoCaja::class, 'turno_caja_id');
    }

    public function detalles(): HasMany
    {
        return $this->hasMany(VentaDetalle::class);
    }
}