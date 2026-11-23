<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Promocion extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'nombre',
        'descripcion',
        'tipo',
        'valor',
        'producto_id',
        'categoria_id',
        'fecha_inicio',
        'fecha_fin',
        'cantidad_minima',
        'activo',
    ];

    protected function casts(): array
    {
        return [
            'valor' => 'decimal:2',
            'fecha_inicio' => 'date',
            'fecha_fin' => 'date',
            'cantidad_minima' => 'integer',
            'activo' => 'boolean',
        ];
    }

    public function producto(): BelongsTo
    {
        return $this->belongsTo(Producto::class);
    }

    public function categoria(): BelongsTo
    {
        return $this->belongsTo(Categoria::class);
    }
}