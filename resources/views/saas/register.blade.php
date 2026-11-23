<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Cuenta de Tienda - TPV Minimarket SaaS</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-100 min-h-screen flex items-center justify-center p-4">
    <div class="bg-white max-w-lg w-full rounded-2xl shadow-xl p-8">
        <div class="text-center mb-6">
            <h1 class="text-2xl font-bold text-slate-800">Registra tu Minimarket</h1>
            <p class="text-sm text-slate-500 mt-1">14 días de prueba gratis. Configura tu caja en segundos.</p>
        </div>

        @if ($errors->any())
            <div class="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 mb-6 text-sm rounded">
                <ul class="list-disc pl-4 space-y-1">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form action="{{ route('saas.register.store') }}" method="POST" class="space-y-4">
            @csrf

            <div class="border-b pb-4 space-y-3">
                <h2 class="text-xs font-semibold uppercase tracking-wider text-blue-600">Datos del Negocio</h2>
                <div>
                    <label class="block text-sm font-medium text-slate-700">Nombre o Razón Social de la Tienda *</label>
                    <input type="text" name="razon_social" value="{{ old('razon_social') }}" required
                        placeholder="Ej. Minimarket El Vecino"
                        class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none">
                </div>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-sm font-medium text-slate-700">NIT / RUC</label>
                        <input type="text" name="ruc_nit" value="{{ old('ruc_nit') }}"
                            class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-blue-500 focus:outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Moneda</label>
                        <select name="codigo_moneda" class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                            <option value="COP" selected>COP ($)</option>
                            <option value="PEN">PEN (S/)</option>
                            <option value="USD">USD ($)</option>
                            <option value="MXN">MXN ($)</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="space-y-3">
                <h2 class="text-xs font-semibold uppercase tracking-wider text-blue-600">Cuenta del Administrador</h2>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Tu Nombre *</label>
                        <input type="text" name="name" value="{{ old('name') }}" required
                            class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Usuario *</label>
                        <input type="text" name="username" value="{{ old('username') }}" required
                            placeholder="admin_tienda"
                            class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-slate-700">Correo Electrónico *</label>
                    <input type="email" name="email" value="{{ old('email') }}" required
                        class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                </div>

                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Contraseña *</label>
                        <input type="password" name="password" required
                            class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-slate-700">Confirmar *</label>
                        <input type="password" name="password_confirmation" required
                            class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    </div>
                </div>
            </div>

            <button type="submit"
                class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2.5 rounded-lg transition shadow-md">
                Crear mi Tienda Gratis
            </button>
        </form>

        <p class="text-center text-xs text-slate-500 mt-4">
            ¿Ya tienes una cuenta? <a href="{{ route('login') }}" class="text-blue-600 font-medium hover:underline">Inicia sesión</a>
        </p>
    </div>
</body>
</html>
