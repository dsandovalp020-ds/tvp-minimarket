<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Cliente extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'codigo',
        'tipo_documento',
        'documento',
        'nombres',
        'apellidos',
        'razon_social',
        'email',
        'telefono',
        'direccion',
        'ciudad',
        'fecha_nacimiento',
        'genero',
        'puntos_fidelidad',
        'credito_limite',
        'credito_usado',
        'observaciones',
        'activo',
    ];

    protected function casts(): array
    {
        return [
            'fecha_nacimiento' => 'date',
            'puntos_fidelidad' => 'integer',
            'credito_limite' => 'decimal:2',
            'credito_usado' => 'decimal:2',
            'activo' => 'boolean',
        ];
    }

    public function ventas(): HasMany
    {
        return $this->hasMany(Venta::class);
    }

    public function puntos(): HasMany
    {
        return $this->hasMany(PuntoFidelidad::class);
    }
}