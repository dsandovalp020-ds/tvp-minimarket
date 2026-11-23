<?php

namespace App\Http\Middleware;

use App\Models\ApiToken;
use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AuthenticateApiToken
{
    public function handle(Request $request, Closure $next): Response
    {
        $plainToken = $request->bearerToken();
        if (!$plainToken) {
            return response()->json(['detail' => 'No autenticado.'], 401);
        }

        $token = ApiToken::with('user.empresa')
            ->where('token_hash', hash('sha256', $plainToken))
            ->where('type', 'access')
            ->where('expires_at', '>', now())
            ->first();

        $user = $token?->user;
        if (!$user || !$user->activo) {
            return response()->json(['detail' => 'Sesión no autorizada.'], 401);
        }

        if (!$user->empresa || !$user->empresa->tieneAccesoVigente()) {
            return response()->json(['detail' => 'La suscripción de la tienda no está vigente.'], 403);
        }

        Auth::setUser($user);
        $request->setUserResolver(fn () => $user);

        return $next($request);
    }
}
