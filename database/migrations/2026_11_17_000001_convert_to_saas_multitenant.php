<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    protected array $tenantTables = [
        'users',
        'configuraciones',
        'categorias',
        'proveedores',
        'productos',
        'clientes',
        'cajas',
        'turnos_caja',
        'movimientos_caja',
        'ventas',
        'puntos_fidelidad',
        'compras',
        'movimientos_inventario',
        'promociones',
        'backups',
        'actividad_log',
    ];

    public function up(): void
    {
        // 1. Agregar control de suscripción y estado a la tabla 'empresas'
        Schema::table('empresas', function (Blueprint $table) {
            if (!Schema::hasColumn('empresas', 'slug')) {
                $table->string('slug', 100)->nullable()->unique()->after('nombre_comercial');
            }
            if (!Schema::hasColumn('empresas', 'plan')) {
                $table->enum('plan', ['trial', 'basico', 'pro', 'empresarial'])->default('trial')->after('terminos_condiciones');
            }
            if (!Schema::hasColumn('empresas', 'trial_hasta')) {
                $table->timestamp('trial_hasta')->nullable()->after('plan');
            }
            if (!Schema::hasColumn('empresas', 'suscripcion_hasta')) {
                $table->timestamp('suscripcion_hasta')->nullable()->after('trial_hasta');
            }
            if (!Schema::hasColumn('empresas', 'activo')) {
                $table->boolean('activo')->default(true)->after('suscripcion_hasta');
            }
        });

        // 2. Agregar empresa_id a todas las tablas operativas y asignar datos existentes a empresa 1
        foreach ($this->tenantTables as $tableName) {
            if (Schema::hasTable($tableName) && !Schema::hasColumn($tableName, 'empresa_id')) {
                Schema::table($tableName, function (Blueprint $table) {
                    $table->foreignId('empresa_id')
                        ->default(1)
                        ->after('id')
                        ->constrained('empresas')
                        ->cascadeOnDelete();

                    $table->index('empresa_id');
                });
            }
        }

        // 3. Reemplazar índices UNIQUE globales por UNIQUE compuestos (empresa_id + campo)
        $this->replaceUniqueWithComposite('productos', 'codigo');
        $this->replaceUniqueWithComposite('clientes', 'codigo');
        $this->replaceUniqueWithComposite('proveedores', 'codigo');
        $this->replaceUniqueWithComposite('compras', 'numero');
        $this->replaceUniqueWithComposite('ventas', 'numero_ticket');
        $this->replaceUniqueWithComposite('configuraciones', 'clave');
    }

    protected function replaceUniqueWithComposite(string $table, string $column): void
    {
        if (!Schema::hasTable($table)) {
            return;
        }

        foreach (Schema::getIndexes($table) as $index) {
            if (
                $index['unique']
                && count($index['columns']) === 1
                && $index['columns'][0] === $column
            ) {
                Schema::table($table, function (Blueprint $tableBlueprint) use ($index) {
                    $tableBlueprint->dropUnique($index['name']);
                });
            }
        }

        Schema::table($table, function (Blueprint $tableBlueprint) use ($table, $column) {
            $tableBlueprint->unique(['empresa_id', $column], "{$table}_empresa_{$column}_unique");
        });
    }

    public function down(): void
    {
        foreach ($this->tenantTables as $tableName) {
            if (Schema::hasTable($tableName) && Schema::hasColumn($tableName, 'empresa_id')) {
                Schema::table($tableName, function (Blueprint $table) {
                    $table->dropForeign(['empresa_id']);
                    $table->dropColumn('empresa_id');
                });
            }
        }
    }
};
