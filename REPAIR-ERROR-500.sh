#!/bin/bash
# REPARACIÓN DE ERROR 500 EN TPV MINIMARKET
# Este script corrige los problemas más comunes

echo "================================"
echo "REPARANDO ERROR 500"
echo "================================"
echo ""

PROJECT_PATH="/home/u182007214/public_html"
cd $PROJECT_PATH

# 1. Verificar que .env existe y está configurado
echo "[1/6] Verificando .env..."
if [ ! -f ".env" ]; then
    echo "ERROR: .env no existe, creando..."
    cp .env.example .env
fi

# Asegurar que tiene la configuración correcta
sed -i 's|^APP_DEBUG=.*|APP_DEBUG=false|' .env
sed -i 's|^APP_ENV=.*|APP_ENV=production|' .env
sed -i 's|^APP_URL=.*|APP_URL=https://tiendago.click|' .env
sed -i 's|^DB_HOST=.*|DB_HOST=localhost|' .env
sed -i 's|^DB_DATABASE=.*|DB_DATABASE=u182007214_lulu_market|' .env
sed -i 's|^DB_USERNAME=.*|DB_USERNAME=u182007214_lulu|' .env
sed -i 's|^DB_PASSWORD=.*|DB_PASSWORD=P4^?ctgDn@ns|' .env
echo "OK"
echo ""

# 2. Generar APP_KEY si no existe
echo "[2/6] Generando APP_KEY..."
php artisan key:generate --force
echo "OK"
echo ""

# 3. Ejecutar migraciones
echo "[3/6] Ejecutando migraciones..."
php artisan migrate --force --step
echo "OK"
echo ""

# 4. Crear storage link
echo "[4/6] Creando storage link..."
php artisan storage:link || echo "Ya existe"
echo "OK"
echo ""

# 5. Configurar permisos correctos
echo "[5/6] Configurando permisos..."
chmod -R 755 storage bootstrap/cache
chmod -R 777 storage/logs
chmod -R 777 storage/app/public
chmod 644 .env
chown -R nobody:nobody storage bootstrap/cache
chown -R nobody:nobody public
echo "OK"
echo ""

# 6. Limpiar y reconstruir cachés
echo "[6/6] Reconstruyendo cachés..."
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize
echo "OK"
echo ""

# 7. Crear .htaccess si no existe
echo "[7/7] Verificando .htaccess..."
if [ ! -f ".htaccess" ]; then
    cat > .htaccess << 'EOF'
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ public/index.php?path=$1 [QSA,L]
</IfModule>
EOF
    echo "Creado"
else
    echo "Ya existe"
fi
echo ""

echo "================================"
echo "REPARACIÓN COMPLETADA"
echo "================================"
echo ""
echo "Pasos siguientes:"
echo "1. Recarga la página: https://tiendago.click"
echo "2. Si aún ves error 500, revisa:"
echo "   tail -50 storage/logs/laravel.log"
echo ""
