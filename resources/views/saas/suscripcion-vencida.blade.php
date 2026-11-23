<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suscripción Vencida - TPV Minimarket SaaS</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen flex items-center justify-center p-4">
    <div class="bg-white max-w-md w-full rounded-2xl shadow-xl p-8 text-center">
        <div class="w-16 h-16 bg-amber-100 text-amber-600 rounded-full flex items-center justify-center mx-auto mb-4 text-2xl font-bold">
            !
        </div>
        <h1 class="text-xl font-bold text-slate-800">Tu período de suscripción ha finalizado</h1>
        <p class="text-sm text-slate-600 mt-2">
            Para continuar utilizando el Punto de Venta y acceder a tus reportes e inventario, renueva tu plan.
        </p>
        <div class="mt-6 space-y-3">
            <a href="#" class="block w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2.5 rounded-lg transition">
                Renovar Plan Ahora
            </a>
            <form action="{{ route('logout') }}" method="POST">
                @csrf
                <button type="submit" class="w-full text-sm text-slate-500 hover:text-slate-700 py-2">
                    Cerrar Sesión
                </button>
            </form>
        </div>
    </div>
</body>
</html>
