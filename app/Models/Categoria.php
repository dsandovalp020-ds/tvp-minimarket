<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Categoria extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'nombre',
        'descripcion',
        'color',
        'icono',
        'activo',
    ];

    protected function casts(): array
    {
        return ['activo' => 'boolean'];
    }

    public function productos(): HasMany
    {
        return $this->hasMany(Producto::class);
    }
}