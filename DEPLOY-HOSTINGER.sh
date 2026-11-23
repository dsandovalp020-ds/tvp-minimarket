#!/bin/bash

# ============================================================================
# TPV MINIMARKET - SCRIPT DE DESPLIEGUE EN HOSTINGER
# ============================================================================
# Este script automatiza la instalación del SaaS en Hostinger
# Uso: bash DEPLOY-HOSTINGER.sh

set -e  # Salir si hay error

# COLORES
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ============================================================================
# CONFIGURACIÓN
# ============================================================================

DOMAIN="tiendago.click"
SSH_USER="u182007214"
SSH_HOST="hydrogen.hostinger.com"  # Cambiar según el servidor de Hostinger
PROJECT_PATH="/home/${SSH_USER}/public_html"
DB_NAME="u182007214_lulu_market"
DB_USER="u182007214_lulu"
DB_PASSWORD="P4^?ctgDn@ns"
DB_HOST="localhost"
REPO_URL="https://github.com/dsandovalp020-ds/tvp-minimarket.git"
BRANCH="master"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   TPV MINIMARKET - DESPLIEGUE EN HOSTINGER                      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================================================
# FUNCIONES
# ============================================================================

function log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

function log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

function log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

function run_remote() {
    # Ejecuta comando en el servidor remoto
    ssh -o StrictHostKeyChecking=no "${SSH_USER}@${SSH_HOST}" "$1"
}

# ============================================================================
# VERIFICACIÓN PREVIA
# ============================================================================

echo -e "${YELLOW}Verificando configuración...${NC}"
echo "Dominio: $DOMAIN"
echo "Usuario SSH: $SSH_USER@$SSH_HOST"
echo "Ruta del proyecto: $PROJECT_PATH"
echo "Base de datos: $DB_NAME"
echo "URL del repositorio: $REPO_URL"
echo ""

# ============================================================================
# 1. CONECTAR Y DESCARGAR REPOSITORIO
# ============================================================================

log_info "Conectando a Hostinger..."
log_info "Descargando repositorio desde GitHub..."

run_remote "
set -e
cd /home/${SSH_USER}

# Crear carpeta si no existe
mkdir -p public_html

# Ir a la carpeta del proyecto
cd public_html

# Si ya existe, hacer pull; si no, clonar
if [ -d .git ]; then
    echo 'Actualizando repositorio existente...'
    git pull origin ${BRANCH}
else
    echo 'Clonando repositorio...'
    git clone --branch ${BRANCH} ${REPO_URL} .
fi

echo 'Repositorio listo.'
"

log_info "✓ Repositorio descargado"

# ============================================================================
# 2. INSTALAR DEPENDENCIAS PHP
# ============================================================================

log_info "Instalando dependencias con Composer..."

run_remote "
cd ${PROJECT_PATH}

# Verificar si composer está instalado
if ! command -v composer &> /dev/null; then
    echo 'Descargando Composer...'
    curl -sS https://getcomposer.org/installer | php
    php composer.phar install --no-dev --optimize-autoloader
else
    composer install --no-dev --optimize-autoloader
fi

echo 'Dependencias instaladas.'
"

log_info "✓ Dependencias instaladas"

# ============================================================================
# 3. CONFIGURAR .env
# ============================================================================

log_info "Configurando archivo .env..."

run_remote "
cd ${PROJECT_PATH}

# Crear .env desde .env.example si no existe
if [ ! -f .env ]; then
    cp .env.example .env
    echo '.env creado'
fi

# Actualizar configuración de base de datos y dominio
sed -i 's|^APP_URL=.*|APP_URL=https://'${DOMAIN}'|' .env
sed -i 's|^DB_HOST=.*|DB_HOST='${DB_HOST}'|' .env
sed -i 's|^DB_DATABASE=.*|DB_DATABASE='${DB_NAME}'|' .env
sed -i 's|^DB_USERNAME=.*|DB_USERNAME='${DB_USER}'|' .env
sed -i 's|^DB_PASSWORD=.*|DB_PASSWORD='${DB_PASSWORD}'|' .env
sed -i 's|^APP_DEBUG=.*|APP_DEBUG=false|' .env

echo '.env configurado'
"

log_info "✓ .env configurado"

# ============================================================================
# 4. GENERAR APP_KEY
# ============================================================================

log_info "Generando APP_KEY..."

run_remote "
cd ${PROJECT_PATH}

php artisan key:generate --force

echo 'APP_KEY generada'
"

log_info "✓ APP_KEY generada"

# ============================================================================
# 5. EJECUTAR MIGRACIONES
# ============================================================================

log_info "Ejecutando migraciones de base de datos..."

run_remote "
cd ${PROJECT_PATH}

# Verificar si la BD está vacía
php artisan migrate --force

echo 'Migraciones completadas'
"

log_info "✓ Migraciones ejecutadas"

# ============================================================================
# 6. CREAR ENLACE DE STORAGE
# ============================================================================

log_info "Creando enlace de storage..."

run_remote "
cd ${PROJECT_PATH}

php artisan storage:link 2>/dev/null || true

echo 'Storage vinculado'
"

log_info "✓ Storage configurado"

# ============================================================================
# 7. LIMPIAR CACHÉS
# ============================================================================

log_info "Limpiando cachés..."

run_remote "
cd ${PROJECT_PATH}

php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize

echo 'Cachés optimizados'
"

log_info "✓ Cachés optimizados"

# ============================================================================
# 8. CONFIGURAR PERMISOS
# ============================================================================

log_info "Configurando permisos de archivos..."

run_remote "
cd ${PROJECT_PATH}

# Permisos para storage
chmod -R 775 storage
chmod -R 775 bootstrap/cache
chmod -R 775 public/uploads
chmod -R 775 public/backups

# Permisos para .env
chmod 600 .env

echo 'Permisos configurados'
"

log_info "✓ Permisos configurados"

# ============================================================================
# 9. CONFIGURAR .htaccess PARA HOSTINGER
# ============================================================================

log_info "Configurando .htaccess..."

run_remote "
cd ${PROJECT_PATH}

# Si existe el archivo en deploy, copiar
if [ -f deploy/hostinger-shared-root.htaccess ]; then
    cp deploy/hostinger-shared-root.htaccess .htaccess
    echo '.htaccess configurado desde deploy'
else
    echo 'Creando .htaccess personalizado'
    cat > .htaccess << 'EOF'
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ public/index.php?path=\$1 [QSA,L]
</IfModule>
EOF
fi

echo '.htaccess listo'
"

log_info "✓ .htaccess configurado"

# ============================================================================
# RESUMEN FINAL
# ============================================================================

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            ✓ DESPLIEGUE COMPLETADO EXITOSAMENTE              ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Información de acceso:${NC}"
echo "  Dominio:  https://${DOMAIN}"
echo "  Ruta:     ${PROJECT_PATH}"
echo "  Repo:     ${REPO_URL}"
echo ""
echo -e "${BLUE}Credenciales de prueba:${NC}"
echo "  Usuario:  admin"
echo "  Contraseña: admin123"
echo ""
echo -e "${BLUE}Próximos pasos:${NC}"
echo "  1. Visita https://${DOMAIN}"
echo "  2. Ingresa con admin / admin123"
echo "  3. Configura los datos de tu empresa"
echo "  4. Comienza a usar el sistema"
echo ""
echo -e "${YELLOW}IMPORTANTE:${NC}"
echo "  - Cambia la contraseña del admin inmediatamente"
echo "  - Configura un SSL válido (Hostinger lo proporciona)"
echo "  - Habilita backups automáticos"
echo "  - Revisa logs en: storage/logs/"
echo ""
