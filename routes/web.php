<?php

use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\TenantRegisterController;
use App\Http\Controllers\CajaController;
use App\Http\Controllers\CategoriaController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\CompraController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\PromocionController;
use App\Http\Controllers\ProveedorController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\UsuarioController;
use App\Http\Controllers\VentaController;
use Illuminate\Support\Facades\Route;

// 1. ZONA PÚBLICA (Landing & Registro SaaS)
Route::get('/', function () {
    return auth()->check()
        ? redirect()->route('dashboard')
        : redirect()->route('login');
})->name('home');

Route::middleware('guest')->group(function () {
    Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
    Route::post('/login', [LoginController::class, 'login']);

    Route::get('/registro-tienda', [TenantRegisterController::class, 'create'])->name('saas.register');
    Route::post('/registro-tienda', [TenantRegisterController::class, 'store'])->name('saas.register.store');
});

Route::post('/logout', [LoginController::class, 'logout'])->name('logout')->middleware('auth');

// 2. ZONA DE SUSCRIPCIÓN / RENOVACIÓN
Route::middleware('auth')->group(function () {
    Route::get('/suscripcion-vencida', function () {
        return view('saas.suscripcion-vencida');
    })->name('saas.suscripcion.vencida');
});

// 3. ZONA OPERATIVA DEL POS (Aislada por Empresa)
Route::middleware(['auth', 'tenant.active'])->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    Route::get('/pos', [VentaController::class, 'pos'])->name('ventas.pos');
    Route::resource('ventas', VentaController::class);
    Route::get('/ventas/{venta}/ticket', [VentaController::class, 'ticket'])->name('ventas.ticket');

    Route::resource('productos', ProductoController::class);
    Route::resource('categorias', CategoriaController::class);
    Route::resource('promociones', PromocionController::class);

    Route::resource('clientes', ClienteController::class);
    Route::resource('proveedores', ProveedorController::class);
    Route::resource('compras', CompraController::class);

    Route::get('/cajas', [CajaController::class, 'index'])->name('caja.index');
    Route::post('/cajas/crear', [CajaController::class, 'storeCaja'])->name('caja.store');
    Route::post('/cajas/abrir', [CajaController::class, 'abrirTurno'])->name('caja.abrir');
    Route::post('/cajas/cerrar/{turno}', [CajaController::class, 'cerrarTurno'])->name('caja.cerrar');
    Route::get('/cajas/cierre/{turno}', [CajaController::class, 'cierre'])->name('caja.cierre');
    Route::post('/cajas/movimiento/{turno}', [CajaController::class, 'movimiento'])->name('caja.movimiento');

    Route::get('/reportes', [ReporteController::class, 'index'])->name('reportes.index');
    Route::get('/reportes/ventas', [ReporteController::class, 'ventas'])->name('reportes.ventas');
    Route::get('/reportes/inventario', [ReporteController::class, 'inventario'])->name('reportes.inventario');
    Route::get('/reportes/productos', [ReporteController::class, 'productos'])->name('reportes.productos');
    Route::get('/reportes/vencimientos', [ReporteController::class, 'vencimientos'])->name('reportes.vencimientos');

    Route::post('/ventas/{venta}/anular', [VentaController::class, 'anular'])->name('ventas.anular');

    Route::get('/configuracion', [ConfiguracionController::class, 'index'])->name('configuracion.index');
    Route::post('/configuracion', [ConfiguracionController::class, 'update'])->name('configuracion.update');

    Route::resource('usuarios', UsuarioController::class);
});
