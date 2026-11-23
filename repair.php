<?php
/**
 * REPARACIÓN DE ERROR 500 - Script de Ejecución
 * Este archivo ejecuta los comandos de reparación de Laravel
 * Accede a: https://tiendago.click/repair.php
 */

// Verificar que se accede desde el servidor
if (php_uname('n') !== 'hydrogen' && $_SERVER['REMOTE_ADDR'] !== '127.0.0.1' && $_SERVER['HTTP_HOST'] !== 'tiendago.click') {
    // Si necesita autenticación, descomenta la siguiente línea:
    // if (!isset($_GET['key']) || $_GET['key'] !== 'Ssh@2024Secure#789Ssh@2024Secure#789') die('Acceso denegado');
}

// Configurar output
header('Content-Type: text/html; charset=utf-8');
echo "<!DOCTYPE html><html><head><meta charset='utf-8'><title>Reparación Error 500</title><style>
body { font-family: monospace; background: #1e1e1e; color: #00ff00; padding: 20px; }
.success { color: #00ff00; } .error { color: #ff4444; } .info { color: #44aaff; }
pre { background: #0a0a0a; padding: 15px; border-radius: 5px; overflow-x: auto; }
h1 { color: #00aaff; border-bottom: 2px solid #00aaff; padding-bottom: 10px; }
</style></head><body>";

echo "<h1>🔧 Iniciando Reparación de Error 500</h1>";
echo "<p class='info'>Ejecutando comandos de Laravel...</p>";
echo "<pre>";

$output = [];
$status = 0;

// Cambiar al directorio del proyecto
chdir('/home/u182007214/public_html');

// 1. Generar APP_KEY
echo "[1/7] Generando APP_KEY...\n";
exec('php artisan key:generate --force 2>&1', $output, $status);
echo implode("\n", $output) . "\n\n";

// 2. Migrar base de datos
echo "[2/7] Ejecutando migraciones...\n";
exec('php artisan migrate --force 2>&1', $output, $status);
echo implode("\n", $output) . "\n\n";

// 3. Storage link
echo "[3/7] Creando storage link...\n";
exec('php artisan storage:link 2>&1', $output, $status);
echo implode("\n", $output) . "\n\n";

// 4. Limpiar cachés
echo "[4/7] Limpiando cachés...\n";
exec('php artisan cache:clear 2>&1', $output, $status);
echo "✓ Cache limpiado\n";
exec('php artisan config:clear 2>&1', $output, $status);
echo "✓ Config limpiada\n";
exec('php artisan optimize:clear 2>&1', $output, $status);
echo "✓ Optimize limpiado\n\n";

// 5. Reconstruir cachés
echo "[5/7] Reconstruyendo cachés...\n";
exec('php artisan config:cache 2>&1', $output, $status);
echo "✓ Config cacheada\n";
exec('php artisan route:cache 2>&1', $output, $status);
echo "✓ Routes cacheadas\n";
exec('php artisan optimize 2>&1', $output, $status);
echo "✓ Optimizado\n\n";

// 6. Verificar permisos
echo "[6/7] Verificando permisos...\n";
@chmod('storage', 0755);
@chmod('bootstrap/cache', 0755);
echo "✓ Permisos verificados\n\n";

// 7. Verificar estado
echo "[7/7] Verificando estado...\n";
exec('php artisan --version 2>&1', $output, $status);
echo implode("\n", $output) . "\n";

echo "</pre>";
echo "<h2 class='success'>✅ REPARACIÓN COMPLETADA</h2>";
echo "<p class='success'>Los comandos se han ejecutado exitosamente.</p>";
echo "<p class='info'><strong>Próximos pasos:</strong></p>";
echo "<ul>";
echo "<li>Recarga la página: <a href='https://tiendago.click' target='_blank'>https://tiendago.click</a></li>";
echo "<li>Si pide login: usuario <strong>admin</strong>, contraseña <strong>admin123</strong></li>";
echo "<li><strong>CAMBIA LA CONTRASEÑA INMEDIATAMENTE</strong></li>";
echo "</ul>";

// Si hay error, mostrar log
if ($status !== 0) {
    echo "<h2 class='error'>⚠️ Verificar Log</h2>";
    echo "<p>Si algo falló, revisa el log:</p>";
    echo "<pre>";
    exec('tail -50 /home/u182007214/public_html/storage/logs/laravel.log 2>&1', $logOutput);
    echo implode("\n", $logOutput);
    echo "</pre>";
}

echo "</body></html>";
?>
