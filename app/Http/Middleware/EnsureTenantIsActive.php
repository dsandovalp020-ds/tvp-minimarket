<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class EnsureTenantIsActive
{
    public function handle(Request $request, Closure $next): Response
    {
        $user = Auth::user();

        if (!$user || !$user->empresa_id || !$user->activo) {
            Auth::logout();
            return redirect()->route('login')->withErrors([
                'email' => 'Tu cuenta no está asociada a una tienda activa.',
            ]);
        }

        $empresa = $user->empresa;

        if (!$empresa || !$empresa->tieneAccesoVigente()) {
            return redirect()->route('saas.suscripcion.vencida');
        }

        return $next($request);
    }
}
