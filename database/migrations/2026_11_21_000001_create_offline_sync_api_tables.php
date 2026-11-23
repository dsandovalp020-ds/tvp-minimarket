<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

return new class extends Migration
{
    public function up(): void
    {
        $this->ensureTenantUniqueIndexes();

        Schema::table('ventas', function (Blueprint $table) {
            $table->uuid('sync_event_id')->nullable()->unique();
        });

        Schema::table('productos', function (Blueprint $table) {
            $table->uuid('sync_id')->nullable()->unique();
            $table->unsignedInteger('sync_version')->default(1);
        });

        DB::table('productos')
            ->whereNull('sync_id')
            ->orderBy('id')
            ->chunkById(500, function ($products) {
                foreach ($products as $product) {
                    DB::table('productos')
                        ->where('id', $product->id)
                        ->update(['sync_id' => (string) Str::uuid()]);
                }
            });

        Schema::create('api_tokens', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->char('token_hash', 64)->unique();
            $table->string('type', 12);
            $table->timestamp('expires_at')->index();
            $table->timestamps();
        });

        Schema::create('sync_events', function (Blueprint $table) {
            $table->uuid('event_id')->primary();
            $table->foreignId('empresa_id')->constrained()->cascadeOnDelete();
            $table->string('event_type', 40);
            $table->json('result');
            $table->timestamps();
            $table->index(['empresa_id', 'created_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sync_events');
        Schema::dropIfExists('api_tokens');
        Schema::table('ventas', function (Blueprint $table) {
            $table->dropUnique(['sync_event_id']);
            $table->dropColumn('sync_event_id');
        });
        Schema::table('productos', function (Blueprint $table) {
            $table->dropUnique(['sync_id']);
            $table->dropColumn(['sync_id', 'sync_version']);
        });
    }

    private function ensureTenantUniqueIndexes(): void
    {
        foreach ([
            'productos' => 'codigo',
            'clientes' => 'codigo',
            'proveedores' => 'codigo',
            'compras' => 'numero',
            'ventas' => 'numero_ticket',
            'configuraciones' => 'clave',
        ] as $tableName => $column) {
            $indexes = Schema::getIndexes($tableName);
            foreach ($indexes as $index) {
                if ($index['unique'] && $index['columns'] === [$column]) {
                    Schema::table($tableName, function (Blueprint $table) use ($index) {
                        $table->dropUnique($index['name']);
                    });
                }
            }

            $hasTenantIndex = collect(Schema::getIndexes($tableName))->contains(
                fn (array $index) => $index['unique']
                    && $index['columns'] === ['empresa_id', $column]
            );
            if (!$hasTenantIndex) {
                Schema::table($tableName, function (Blueprint $table) use ($column, $tableName) {
                    $table->unique(
                        ['empresa_id', $column],
                        "{$tableName}_empresa_{$column}_unique"
                    );
                });
            }
        }

        $userIndexes = Schema::getIndexes('users');
        foreach ($userIndexes as $index) {
            if ($index['unique'] && $index['columns'] === ['empresa_id', 'username']) {
                Schema::table('users', function (Blueprint $table) use ($index) {
                    $table->dropUnique($index['name']);
                });
            }
        }
        $hasGlobalUsernameIndex = collect(Schema::getIndexes('users'))->contains(
            fn (array $index) => $index['unique'] && $index['columns'] === ['username']
        );
        if (!$hasGlobalUsernameIndex) {
            Schema::table('users', function (Blueprint $table) {
                $table->unique('username');
            });
        }
    }
};
