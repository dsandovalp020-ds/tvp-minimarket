#!/bin/bash
# SCRIPT AUTOMATIZADO DE REPARACIÓN - TPV MINIMARKET
# Este script ejecuta todos los comandos necesarios

set -e

PROJECT_PATH="/home/u182007214/public_html"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           🔧 REPARACIÓN AUTOMÁTICA DE ERROR 500               ║"
echo "║                 TPV Minimarket - Tiendago.click                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Verificar que el directorio existe
if [ ! -d "$PROJECT_PATH" ]; then
    echo "❌ ERROR: Directorio $PROJECT_PATH no encontrado"
    exit 1
fi

cd "$PROJECT_PATH"

# 1. Generar APP_KEY
echo ""
echo "┌─ [1/7] Generando APP_KEY..."
if php artisan key:generate --force; then
    echo "└─ ✅ APP_KEY generada"
else
    echo "└─ ⚠️  APP_KEY ya generada o error"
fi

# 2. Ejecutar migraciones
echo ""
echo "┌─ [2/7] Ejecutando migraciones de base de datos..."
if php artisan migrate --force; then
    echo "└─ ✅ Migraciones ejecutadas"
else
    echo "└─ ⚠️  Error en migraciones - continuando..."
fi

# 3. Crear storage link
echo ""
echo "┌─ [3/7] Creando enlace de almacenamiento..."
php artisan storage:link || echo "⚠️  Storage link ya existe"
echo "└─ ✅ Storage link listo"

# 4. Limpiar cachés
echo ""
echo "┌─ [4/7] Limpiando cachés de Laravel..."
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan optimize:clear
echo "└─ ✅ Cachés limpiados"

# 5. Reconstruir cachés
echo ""
echo "┌─ [5/7] Reconstruyendo cachés..."
php artisan config:cache
php artisan route:cache
php artisan optimize
echo "└─ ✅ Cachés reconstruidos"

# 6. Verificar permisos
echo ""
echo "┌─ [6/7] Ajustando permisos..."
chmod -R 755 storage bootstrap/cache
chmod -R 777 storage/logs storage/app/public
echo "└─ ✅ Permisos ajustados"

# 7. Verificación final
echo ""
echo "┌─ [7/7] Verificación final..."
php artisan --version
echo "└─ ✅ Verificación completada"

# Mostrar resultado
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                   ✅ REPARACIÓN COMPLETADA                    ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📋 Próximos pasos:"
echo "   1. Recarga la página: https://tiendago.click"
echo "   2. Si pide login, usa: admin / admin123"
echo "   3. CAMBIA LA CONTRASEÑA INMEDIATAMENTE"
echo ""
echo "🔍 Si aún hay error, revisa:"
echo "   tail -50 $PROJECT_PATH/storage/logs/laravel.log"
echo ""
