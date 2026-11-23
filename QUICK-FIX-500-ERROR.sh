#!/bin/bash
# REPARACIÓN RÁPIDA DE ERROR 500 - TPV MINIMARKET
# Copiar y pegar línea por línea en el Terminal de Hostinger

cd /home/u182007214/public_html

echo "================================"
echo "INICIANDO REPARACIÓN"
echo "================================"

# 1. Generar APP_KEY
echo ""
echo "[1/5] Generando APP_KEY..."
php artisan key:generate --force

# 2. Ejecutar migraciones
echo ""
echo "[2/5] Ejecutando migraciones..."
php artisan migrate --force

# 3. Crear storage link
echo ""
echo "[3/5] Creando storage link..."
php artisan storage:link

# 4. Limpiar todos los cachés
echo ""
echo "[4/5] Limpiando cachés..."
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan optimize:clear

# 5. Reconstruir cachés
echo ""
echo "[5/5] Reconstruyendo cachés..."
php artisan config:cache
php artisan route:cache
php artisan optimize

echo ""
echo "================================"
echo "✅ REPARACIÓN COMPLETADA"
echo "================================"
echo ""
echo "Verifica la aplicación en:"
echo "https://tiendago.click"
