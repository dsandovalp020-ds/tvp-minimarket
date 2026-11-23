<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleSeeder extends Seeder
{
    public function run(): void
    {
        foreach ([
            [
                'nombre' => 'Administrador',
                'descripcion' => 'Acceso completo al sistema',
                'permisos' => ['*'],
                'activo' => true,
            ],
            [
                'nombre' => 'Gerente',
                'descripcion' => 'Gestión completa excepto configuración del sistema',
                'permisos' => ['productos', 'ventas', 'compras', 'clientes', 'proveedores', 'caja', 'reportes', 'promociones'],
                'activo' => true,
            ],
            [
                'nombre' => 'Cajero',
                'descripcion' => 'Acceso al punto de venta y caja',
                'permisos' => ['ventas', 'caja', 'clientes'],
                'activo' => true,
            ],
            [
                'nombre' => 'Almacenero',
                'descripcion' => 'Gestión de inventario y compras',
                'permisos' => ['productos', 'compras', 'proveedores', 'reportes'],
                'activo' => true,
            ],
        ] as $role) {
            Role::firstOrCreate(['nombre' => $role['nombre']], $role);
        }
    }
}
