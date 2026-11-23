<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Models\Configuracion;
use Illuminate\Support\Facades\View;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        // Compartir datos de empresa y configuración con todas las vistas
        View::composer('*', function ($view) {
            $user = auth()->user();
            $empresa = $user?->empresa;
            $config = $user
                ? Configuracion::where('empresa_id', $user->empresa_id)->pluck('valor', 'clave')->toArray()
                : [];

            $view->with('empresaGlobal', $empresa)
                ->with('configGlobal', $config);
        });
    }
}
