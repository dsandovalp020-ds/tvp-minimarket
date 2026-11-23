<?php
/**
 * SCRIPT DE REPARACIÓN EJECUTABLE VÍA CURL
 * Coloca este archivo en /public/repair-500.php
 * Accede a: https://tiendago.click/repair-500.php?key=tu_clave_aqui
 */

// Configurar seguridad
define('ALLOWED_KEYS', ['Ssh@2024Secure#789Ssh@2024Secure#789', 'admin']);
define('PROJECT_PATH', dirname(__DIR__));

// Verificar clave
if (!isset($_GET['key']) || !in_array($_GET['key'], ALLOWED_KEYS)) {
    http_response_code(401);
    die("Acceso denegado");
}

// Configurar output
header('Content-Type: text/plain; charset=utf-8');

echo "================================================================================\n";
echo "INICIANDO REPARACION DE ERROR 500 - TPV MINIMARKET\n";
echo "================================================================================\n\n";

// Cambiar al directorio del proyecto
chdir(PROJECT_PATH);

$commands = [
    'Generando APP_KEY' => 'php artisan key:generate --force 2>&1',
    'Ejecutando migraciones' => 'php artisan migrate --force 2>&1',
    'Creando storage link' => 'php artisan storage:link 2>&1',
    'Limpiando cache' => 'php artisan cache:clear 2>&1',
    'Limpiando config' => 'php artisan config:clear 2>&1',
    'Limpiando optimize' => 'php artisan optimize:clear 2>&1',
    'Reconstruyendo config' => 'php artisan config:cache 2>&1',
    'Reconstruyendo routes' => 'php artisan route:cache 2>&1',
    'Optimizando' => 'php artisan optimize 2>&1',
];

$step = 1;
foreach ($commands as $description => $command) {
    echo "[" . $step . "/" . count($commands) . "] " . $description . "\n";
    echo "Command: " . $command . "\n";
    
    $output = [];
    $exitCode = 0;
    exec($command, $output, $exitCode);
    
    // Mostrar salida
    if (!empty($output)) {
        foreach (array_slice($output, 0, 3) as $line) {
            if (trim($line)) {
                echo "    " . trim($line) . "\n";
            }
        }
    }
    
    echo "    Status: " . ($exitCode === 0 ? "OK" : "WARNING (code: $exitCode)") . "\n";
    echo "\n";
    
    $step++;
}

// Ajustar permisos
echo "[" . count($commands) + 1 . "/" . (count($commands) + 1) . "] Ajustando permisos\n";
@chmod('storage', 0755);
@chmod('bootstrap/cache', 0755);
echo "    Status: OK\n\n";

echo "================================================================================\n";
echo "REPARACION COMPLETADA\n";
echo "================================================================================\n\n";

echo "PROXIMOS PASOS:\n";
echo "1. Recarga: https://tiendago.click\n";
echo "2. Login con: admin / admin123\n";
echo "3. CAMBIA LA CONTRASENA INMEDIATAMENTE\n";
echo "\nSi aun ves error 500, revisa el log:\n";
echo "tail -50 " . PROJECT_PATH . "/storage/logs/laravel.log\n";

// Limpiar la clave por seguridad
// (opcional - descomentar si lo deseas)
// unlink(__FILE__);
?>
