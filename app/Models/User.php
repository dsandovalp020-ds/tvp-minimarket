<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use App\Traits\BelongsToEmpresa;

class User extends Authenticatable
{
    use HasFactory, Notifiable, BelongsToEmpresa;

    protected $fillable = [
        'empresa_id',
        'name',
        'username',
        'email',
        'password',
        'role_id',
        'telefono',
        'avatar',
        'activo',
        'ultimo_login',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'ultimo_login'      => 'datetime',
            'password'          => 'hashed',
            'activo'            => 'boolean',
        ];
    }

    public function empresa(): BelongsTo
    {
        return $this->belongsTo(Empresa::class);
    }

    public function role(): BelongsTo
    {
        return $this->belongsTo(Role::class);
    }

    public function isAdmin(): bool
    {
        return $this->role?->nombre === 'Administrador';
    }

    public function hasPermission(string $permission): bool
    {
        $permissions = $this->role?->permisos ?? [];

        return in_array('*', $permissions, true)
            || in_array($permission, $permissions, true);
    }
}
