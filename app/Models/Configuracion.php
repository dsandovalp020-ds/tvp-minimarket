<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    use BelongsToEmpresa;

    protected $fillable = ['empresa_id', 'clave', 'valor', 'tipo', 'grupo', 'descripcion'];

    public static function set(string $clave, mixed $valor): self
    {
        return static::updateOrCreate(
            ['clave' => $clave],
            ['valor' => is_scalar($valor) ? (string) $valor : json_encode($valor)]
        );
    }
}