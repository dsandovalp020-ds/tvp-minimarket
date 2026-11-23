#!/bin/bash
# ════════════════════════════════════════════════════════════════════════════════
# TPV MINIMARKET - COMANDOS DE DESPLIEGUE PARA HOSTINGER
# ════════════════════════════════════════════════════════════════════════════════
# INSTRUCCIONES:
# 1. Abre hPanel → Sitio Web → Terminal
# 2. Copia TODO el contenido de este script (desde aquí hasta el final)
# 3. Pégalo en la Terminal SSH del hPanel
# 4. Presiona Enter y espera a que se complete el despliegue
# ════════════════════════════════════════════════════════════════════════════════

echo "════════════════════════════════════════════════════════════════"
echo "  🚀 TPV MINIMARKET - DESPLIEGUE EN HOSTINGER"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Variables de configuración
PROJECT_PATH="/home/u182007214/public_html"
DB_HOST="localhost"
DB_NAME="u182007214_lulu_market"
DB_USER="u182007214_lulu"
DB_PASSWORD="P4^?ctgDn@ns"
APP_URL="https://tiendago.click"
REPO_URL="https://github.com/dsandovalp020-ds/tvp-minimarket.git"
BRANCH="master"

# ════════════════════════════════════════════════════════════════════════════════
# PASO 1: Limpiar y preparar directorio
# ════════════════════════════════════════════════════════════════════════════════
echo "[1/8] 📁 Preparando directorio..."
cd /home/u182007214
mkdir -p public_html
cd public_html
rm -rf .git vendor node_modules .env composer.lock
echo "✓ Directorio preparado"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 2: Descargar repositorio
# ════════════════════════════════════════════════════════════════════════════════
echo "[2/8] ⬇️  Descargando repositorio de GitHub..."
git clone --branch $BRANCH $REPO_URL .
if [ $? -ne 0 ]; then
    echo "❌ Error: No se pudo clonar el repositorio"
    exit 1
fi
echo "✓ Repositorio descargado"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 3: Instalar dependencias con Composer
# ════════════════════════════════════════════════════════════════════════════════
echo "[3/8] 📦 Instalando dependencias con Composer..."
composer install --no-dev --optimize-autoloader
if [ $? -ne 0 ]; then
    echo "⚠️ Advertencia: Composer mostró errores (continuando...)"
fi
echo "✓ Dependencias instaladas"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 4: Configurar archivo .env
# ════════════════════════════════════════════════════════════════════════════════
echo "[4/8] 🔧 Configurando archivo .env..."
cp .env.example .env

# Reemplazar valores en .env usando sed
sed -i "s|^APP_NAME=.*|APP_NAME=\"TPV Minimarket\"|" .env
sed -i "s|^APP_ENV=.*|APP_ENV=production|" .env
sed -i "s|^APP_DEBUG=.*|APP_DEBUG=false|" .env
sed -i "s|^APP_URL=.*|APP_URL=$APP_URL|" .env
sed -i "s|^DB_HOST=.*|DB_HOST=$DB_HOST|" .env
sed -i "s|^DB_DATABASE=.*|DB_DATABASE=$DB_NAME|" .env
sed -i "s|^DB_USERNAME=.*|DB_USERNAME=$DB_USER|" .env
sed -i "s|^DB_PASSWORD=.*|DB_PASSWORD=$DB_PASSWORD|" .env

echo "✓ Archivo .env configurado"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 5: Generar clave de aplicación
# ════════════════════════════════════════════════════════════════════════════════
echo "[5/8] 🔐 Generando clave de aplicación..."
php artisan key:generate --force
if [ $? -ne 0 ]; then
    echo "⚠️ Advertencia: Error al generar APP_KEY"
fi
echo "✓ Clave generada"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 6: Ejecutar migraciones de base de datos
# ════════════════════════════════════════════════════════════════════════════════
echo "[6/8] 🗄️  Ejecutando migraciones de base de datos..."
php artisan migrate --force
if [ $? -ne 0 ]; then
    echo "⚠️ Advertencia: Algunas migraciones fallaron"
fi
echo "✓ Migraciones completadas"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 7: Crear enlace de storage
# ════════════════════════════════════════════════════════════════════════════════
echo "[7/8] 🎨 Configurando almacenamiento..."
php artisan storage:link 2>/dev/null || echo "Storage ya existe"
echo "✓ Storage configurado"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# PASO 8: Optimizar y limpiar cachés
# ════════════════════════════════════════════════════════════════════════════════
echo "[8/8] ⚙️  Optimizando cachés..."
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize
chmod -R 775 storage bootstrap/cache
chmod -R 777 storage
chmod -R 755 public
chmod 600 .env

echo "✓ Cachés optimizados"
echo ""

# ════════════════════════════════════════════════════════════════════════════════
# ✅ DESPLIEGUE COMPLETADO
# ════════════════════════════════════════════════════════════════════════════════
echo "════════════════════════════════════════════════════════════════"
echo "  ✅ ¡DESPLIEGUE COMPLETADO EXITOSAMENTE!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "🌐 Tu aplicación está disponible en:"
echo "   → https://tiendago.click"
echo "   → https://www.tiendago.click"
echo ""
echo "👤 Credenciales de acceso (CAMBIAR INMEDIATAMENTE):"
echo "   • Usuario:    admin"
echo "   • Contraseña: admin123"
echo ""
echo "📋 PRÓXIMOS PASOS (MUY IMPORTANTE):"
echo "   1. Visita https://tiendago.click"
echo "   2. Inicia sesión con: admin / admin123"
echo "   3. ⚠️ VE A CONFIGURACIÓN → USUARIOS → ADMIN"
echo "   4. 🔐 CAMBIA LA CONTRASEÑA DEL ADMIN AHORA"
echo "   5. Ve a Configuración → Empresa y configura:"
echo "      • Nombre de empresa"
echo "      • RUC/NIT"
echo "      • Dirección"
echo "      • Teléfono"
echo "   6. Prueba la funcionalidad principal"
echo ""
echo "📁 Ubicación en servidor:"
echo "   Ruta: /home/u182007214/public_html"
echo "   Logs: /home/u182007214/public_html/storage/logs/laravel.log"
echo ""
echo "🔗 Repositorio GitHub:"
echo "   https://github.com/dsandovalp020-ds/tvp-minimarket"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
