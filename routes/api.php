<?php

use App\Http\Controllers\Api\TiendaGoApiController;
use App\Http\Middleware\AuthenticateApiToken;
use Illuminate\Support\Facades\Route;

Route::post('auth/token/', [TiendaGoApiController::class, 'token'])->middleware('throttle:10,1');
Route::post('auth/token/refresh/', [TiendaGoApiController::class, 'refresh'])->middleware('throttle:30,1');

Route::middleware([AuthenticateApiToken::class, 'throttle:120,1'])->group(function () {
    Route::get('store/', [TiendaGoApiController::class, 'store']);
    Route::get('products/', [TiendaGoApiController::class, 'products']);
    Route::get('orders/', [TiendaGoApiController::class, 'orders']);
    Route::post('sync/', [TiendaGoApiController::class, 'sync']);
});
