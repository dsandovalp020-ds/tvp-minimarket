#!/bin/bash
# Script de diagnóstico del servidor

echo "================================"
echo "DIAGNÓSTICO DEL SERVIDOR"
echo "================================"
echo ""

PROJECT_PATH="/home/u182007214/public_html"

echo "1️⃣ Verificando estructura de directorios..."
ls -la $PROJECT_PATH | head -20
echo ""

echo "2️⃣ Revisando archivo .env..."
head -20 $PROJECT_PATH/.env
echo ""

echo "3️⃣ Verificando última línea del log..."
tail -20 $PROJECT_PATH/storage/logs/laravel.log
echo ""

echo "4️⃣ Verificando versión de PHP..."
php -v
echo ""

echo "5️⃣ Verificando permisos de carpetas críticas..."
ls -ld $PROJECT_PATH/storage
ls -ld $PROJECT_PATH/bootstrap/cache
ls -ld $PROJECT_PATH/public
echo ""

echo "6️⃣ Verificando que php artisan funciona..."
cd $PROJECT_PATH
php artisan --version
echo ""

echo "================================"
echo "DIAGNÓSTICO COMPLETADO"
echo "================================"
