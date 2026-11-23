<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Empresa extends Model
{
    protected $table = 'empresas';

    protected $fillable = [
        'razon_social',
        'nombre_comercial',
        'slug',
        'ruc_nit',
        'direccion',
        'ciudad',
        'telefono',
        'email',
        'sitio_web',
        'logo',
        'moneda',
        'codigo_moneda',
        'impuesto',
        'impuesto_incluido',
        'mensaje_ticket',
        'terminos_condiciones',
        'plan',
        'trial_hasta',
        'suscripcion_hasta',
        'activo',
    ];

    protected $casts = [
        'impuesto'          => 'decimal:2',
        'impuesto_incluido' => 'boolean',
        'activo'            => 'boolean',
        'trial_hasta'       => 'datetime',
        'suscripcion_hasta' => 'datetime',
    ];

    public function users(): HasMany
    {
        return $this->hasMany(User::class);
    }

    public function tieneAccesoVigente(): bool
    {
        if (!$this->activo) {
            return false;
        }

        if ($this->plan === 'trial' && $this->trial_hasta) {
            return now()->lte($this->trial_hasta);
        }

        if ($this->suscripcion_hasta) {
            return now()->lte($this->suscripcion_hasta);
        }

        return true;
    }
}
