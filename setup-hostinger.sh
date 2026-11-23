#!/bin/bash
# Script de despliegue automático para Hostinger
# Uso: Copiar este contenido en la TERMINAL del panel de Hostinger

set -e

echo "================================"
echo "TPV MINIMARKET - SETUP AUTOMÁTICO"
echo "================================"
echo ""

# Configuración
DOMAIN="tiendago.click"
PROJECT_PATH="/domains/${DOMAIN}/public_html"
DB_NAME="u182007214_lulu_market"
DB_USER="u182007214_lulu"
DB_PASSWORD="P4^?ctgDn@ns"

echo "📂 Yendo a la carpeta del proyecto..."
cd "$PROJECT_PATH"

# 1. Instalar dependencias
echo "📦 Instalando dependencias con Composer..."
if command -v composer &> /dev/null; then
    composer install --no-dev --optimize-autoloader
else
    echo "⚠️ Composer no encontrado. Instalando..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    php composer.phar install --no-dev --optimize-autoloader
fi

# 2. Crear .env si no existe
echo "⚙️ Configurando .env..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✓ .env creado desde .env.example"
fi

# Actualizar configuración
sed -i "s|^APP_URL=.*|APP_URL=https://www.${DOMAIN}|" .env
sed -i "s|^APP_DEBUG=.*|APP_DEBUG=false|" .env
sed -i "s|^APP_ENV=.*|APP_ENV=production|" .env
sed -i "s|^DB_HOST=.*|DB_HOST=localhost|" .env
sed -i "s|^DB_DATABASE=.*|DB_DATABASE=${DB_NAME}|" .env
sed -i "s|^DB_USERNAME=.*|DB_USERNAME=${DB_USER}|" .env
sed -i "s|^DB_PASSWORD=.*|DB_PASSWORD=${DB_PASSWORD}|" .env

# 3. Generar APP_KEY
echo "🔐 Generando APP_KEY..."
php artisan key:generate --force

# 4. Migraciones
echo "🗄️ Ejecutando migraciones..."
php artisan migrate --force

# 5. Storage link
echo "🔗 Configurando storage..."
php artisan storage:link 2>/dev/null || echo "Storage ya configurado"

# 6. Optimizar cachés
echo "⚡ Optimizando cachés..."
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize

# 7. Permisos
echo "🔒 Configurando permisos..."
chmod -R 775 storage bootstrap/cache public/uploads public/backups
chmod 644 .env

# 8. Limpiar logs antiguos
echo "🧹 Limpiando logs..."
rm -f storage/logs/laravel.log

echo ""
echo "================================"
echo "✅ SETUP COMPLETADO EXITOSAMENTE"
echo "================================"
echo ""
echo "Tu aplicación está disponible en:"
echo "🌐 https://www.${DOMAIN}"
echo ""
echo "Usuario de prueba:"
echo "👤 admin"
echo "🔑 admin123"
echo ""
echo "⚠️ IMPORTANTE:"
echo "  1. Cambia la contraseña del admin INMEDIATAMENTE"
echo "  2. Configura un SSL válido (Hostinger lo proporciona)"
echo "  3. Habilita backups automáticos"
echo ""
