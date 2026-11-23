<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PuntoFidelidad extends Model
{
    use BelongsToEmpresa;

    protected $table = 'puntos_fidelidad';

    protected $fillable = [
        'empresa_id',
        'cliente_id',
        'venta_id',
        'tipo',
        'puntos',
        'saldo_anterior',
        'saldo_nuevo',
        'descripcion',
    ];

    protected function casts(): array
    {
        return [
            'puntos' => 'integer',
            'saldo_anterior' => 'integer',
            'saldo_nuevo' => 'integer',
        ];
    }

    public function cliente(): BelongsTo
    {
        return $this->belongsTo(Cliente::class);
    }

    public function venta(): BelongsTo
    {
        return $this->belongsTo(Venta::class);
    }
}