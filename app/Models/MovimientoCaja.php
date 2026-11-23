<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MovimientoCaja extends Model
{
    use BelongsToEmpresa;

    protected $table = 'movimientos_caja';

    protected $fillable = [
        'empresa_id',
        'turno_caja_id',
        'user_id',
        'tipo',
        'concepto',
        'monto',
        'observaciones',
    ];

    protected function casts(): array
    {
        return ['monto' => 'decimal:2'];
    }

    public function turno(): BelongsTo
    {
        return $this->belongsTo(TurnoCaja::class, 'turno_caja_id');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}