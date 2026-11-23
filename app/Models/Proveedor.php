<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Proveedor extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'codigo',
        'razon_social',
        'nombre_comercial',
        'ruc_nit',
        'contacto',
        'email',
        'telefono',
        'direccion',
        'ciudad',
        'observaciones',
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

    public function compras(): HasMany
    {
        return $this->hasMany(Compra::class);
    }
}