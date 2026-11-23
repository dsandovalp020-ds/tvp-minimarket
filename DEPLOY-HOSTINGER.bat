@echo off
REM ============================================================================
REM TPV MINIMARKET - DESPLIEGUE EN HOSTINGER (WINDOWS)
REM ============================================================================
REM Este script automatiza la instalación del SaaS en Hostinger
REM Uso: DEPLOY-HOSTINGER.bat

setlocal enabledelayedexpansion
chcp 65001 >nul

REM COLORES
set GREEN=[92m
set YELLOW=[93m
set BLUE=[94m
set RED=[91m
set RESET=[0m

REM ============================================================================
REM CONFIGURACIÓN
REM ============================================================================

set DOMAIN=tiendago.click
set SSH_USER=u182007214
set SSH_HOST=hydrogen.hostinger.com
set SSH_PORT=22
set PROJECT_PATH=/home/%SSH_USER%/public_html
set DB_NAME=u182007214_lulu_market
set DB_USER=u182007214_lulu
set DB_PASSWORD=P4^?ctgDn@ns
set DB_HOST=localhost
set REPO_URL=https://github.com/dsandovalp020-ds/tvp-minimarket.git
set BRANCH=master

echo.
echo ============================================================
echo   TPV MINIMARKET - DESPLIEGUE EN HOSTINGER
echo ============================================================
echo.
echo Configuración:
echo   Dominio:     %DOMAIN%
echo   Usuario SSH: %SSH_USER%@%SSH_HOST%
echo   Ruta:        %PROJECT_PATH%
echo   Database:    %DB_NAME%
echo.

REM ============================================================================
REM VERIFICAR SSH
REM ============================================================================

where ssh >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERROR] OpenSSH no está instalado.
    echo.
    echo Opciones:
    echo 1. Windows 10/11: Instalar desde Settings ^> Apps ^> Optional Features
    echo 2. Usar Git Bash (incluye ssh)
    echo 3. Instalar PuTTY y usar plink
    echo.
    pause
    exit /b 1
)

echo [OK] SSH disponible

REM ============================================================================
REM FUNCIONES SSH
REM ============================================================================

:ssh_command
REM Ejecutar comando en servidor remoto
REM Uso: call :ssh_command "comando aqui"
set CMD=%1
ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% "%CMD%"
exit /b

REM ============================================================================
REM 1. CONECTAR Y DESCARGAR REPOSITORIO
REM ============================================================================

echo.
echo [1/8] Descargando repositorio de GitHub...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd /home/%SSH_USER% && "^
  "mkdir -p public_html && "^
  "cd public_html && "^
  "if [ -d .git ]; then git pull origin %BRANCH%; else git clone --branch %BRANCH% %REPO_URL% . ; fi && "^
  "echo 'Repositorio listo.'"

if errorlevel 1 (
    echo [ERROR] Falló la descarga del repositorio
    pause
    exit /b 1
)

echo [OK] Repositorio descargado

REM ============================================================================
REM 2. INSTALAR DEPENDENCIAS PHP
REM ============================================================================

echo.
echo [2/8] Instalando dependencias con Composer...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "composer install --no-dev --optimize-autoloader && "^
  "echo 'Dependencias instaladas.'"

if errorlevel 1 (
    echo [ERROR] Falló instalación de Composer
    pause
    exit /b 1
)

echo [OK] Dependencias instaladas

REM ============================================================================
REM 3. CONFIGURAR .env
REM ============================================================================

echo.
echo [3/8] Configurando archivo .env...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "cp -n .env.example .env && "^
  "sed -i 's|^APP_URL=.*|APP_URL=https://%DOMAIN%|' .env && "^
  "sed -i 's|^DB_HOST=.*|DB_HOST=%DB_HOST%|' .env && "^
  "sed -i 's|^DB_DATABASE=.*|DB_DATABASE=%DB_NAME%|' .env && "^
  "sed -i 's|^DB_USERNAME=.*|DB_USERNAME=%DB_USER%|' .env && "^
  "sed -i 's|^APP_DEBUG=.*|APP_DEBUG=false|' .env && "^
  "echo '.env configurado'"

echo [OK] .env configurado

REM ============================================================================
REM 4. GENERAR APP_KEY
REM ============================================================================

echo.
echo [4/8] Generando APP_KEY...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "php artisan key:generate --force && "^
  "echo 'APP_KEY generada'"

echo [OK] APP_KEY generada

REM ============================================================================
REM 5. EJECUTAR MIGRACIONES
REM ============================================================================

echo.
echo [5/8] Ejecutando migraciones de base de datos...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "php artisan migrate --force && "^
  "echo 'Migraciones completadas'"

echo [OK] Migraciones ejecutadas

REM ============================================================================
REM 6. CREAR ENLACE DE STORAGE
REM ============================================================================

echo.
echo [6/8] Creando enlace de storage...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "php artisan storage:link 2^>/dev/null ^| ^| true && "^
  "echo 'Storage vinculado'"

echo [OK] Storage configurado

REM ============================================================================
REM 7. LIMPIAR CACHÉS
REM ============================================================================

echo.
echo [7/8] Optimizando cachés...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "php artisan config:cache && "^
  "php artisan route:cache && "^
  "php artisan view:cache && "^
  "php artisan optimize && "^
  "echo 'Cachés optimizados'"

echo [OK] Cachés optimizados

REM ============================================================================
REM 8. CONFIGURAR PERMISOS
REM ============================================================================

echo.
echo [8/8] Configurando permisos...
echo.

ssh -p %SSH_PORT% %SSH_USER%@%SSH_HOST% ^
  "cd %PROJECT_PATH% && "^
  "chmod -R 775 storage bootstrap/cache public/uploads public/backups && "^
  "chmod 600 .env && "^
  "echo 'Permisos configurados'"

echo [OK] Permisos configurados

REM ============================================================================
REM RESUMEN FINAL
REM ============================================================================

echo.
echo ============================================================
echo            DESPLIEGUE COMPLETADO EXITOSAMENTE
echo ============================================================
echo.
echo Acceso:
echo   Dominio:    https://%DOMAIN%
echo   Ruta:       %PROJECT_PATH%
echo.
echo Credenciales de prueba:
echo   Usuario:    admin
echo   Contraseña: admin123
echo.
echo Próximos pasos:
echo   1. Visita https://%DOMAIN%
echo   2. Ingresa con admin / admin123
echo   3. Cambia la contraseña inmediatamente
echo   4. Configura los datos de tu empresa
echo.
echo Logs y mantenimiento:
echo   Logs:       %PROJECT_PATH%/storage/logs/
echo   SSH:        ssh %SSH_USER%@%SSH_HOST%
echo.
pause
endlocal
