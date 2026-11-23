<?php

namespace App\Models;

use App\Traits\BelongsToEmpresa;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Backup extends Model
{
    use BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'user_id',
        'nombre',
        'archivo',
        'tamano',
        'tipo',
        'observaciones',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}