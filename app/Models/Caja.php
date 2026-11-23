<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Caja extends Model
{
    use BelongsToEmpresa;

    protected $fillable = ['empresa_id', 'nombre', 'descripcion', 'activo'];

    protected function casts(): array
    {
        return ['activo' => 'boolean'];
    }

    public function turnos(): HasMany
    {
        return $this->hasMany(TurnoCaja::class);
    }
}