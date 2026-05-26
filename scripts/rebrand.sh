#!/bin/bash
set -e
# PixquiCloud rebrand script
# Compatible con macOS + MAMP + Ubuntu + aaPanel

#################################################
# CONFIG
#################################################

# Detectar automáticamente la raíz de Nextcloud
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NC_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"


#################################################
# DETECTAR PHP
#################################################

if [ -x "/www/server/php/83/bin/php" ]; then
    PHP="/www/server/php/83/bin/php"
elif command -v php >/dev/null 2>&1; then
    PHP="$(command -v php)"
else
    echo "ERROR: PHP no encontrado"
    exit 1
fi

#################################################
# DETECTAR USUARIO WEB
#################################################

WEB_USER="www"

id "$WEB_USER" >/dev/null 2>&1 || WEB_USER="www-data"
id "$WEB_USER" >/dev/null 2>&1 || WEB_USER="apache"
id "$WEB_USER" >/dev/null 2>&1 || WEB_USER="_www"

if ! id "$WEB_USER" >/dev/null 2>&1; then
    echo "ERROR: No se pudo detectar usuario web"
    exit 1
fi

#################################################
# OCC HELPER
#################################################

occ() {
    sudo -u "$WEB_USER" "$PHP" "$NC_ROOT/occ" "$@"
}

runweb() {
    sudo -u "$WEB_USER" "$@"
}

IMG_DIR="$NC_ROOT/themes/pixqui/core/img/logo"
BG_DIR="$NC_ROOT/themes/pixqui/core/img/background"

echo "Aplicando rebrand PixquiCloud..."
echo "Usando PHP: $PHP"
$PHP -v | head -n 1
echo "Usando usuario web: $WEB_USER"

#################################################
# FIX PERMISOS
#################################################

chown -R "$WEB_USER":"$WEB_USER" "$NC_ROOT/config" 2>/dev/null || true
chmod 750 "$NC_ROOT/config" 2>/dev/null || true
chmod 640 "$NC_ROOT/config/config.php" 2>/dev/null || true

chown -R "$WEB_USER":"$WEB_USER" "$NC_ROOT/data" 2>/dev/null || true
chmod -R 750 "$NC_ROOT/data" 2>/dev/null || true

#################################################
# VALIDAR NEXTCLOUD
#################################################

if [ ! -f "$NC_ROOT/occ" ]; then
    echo "ERROR: occ no encontrado en:"
    echo "$NC_ROOT"
    exit 1
fi

#################################################
# TEST OCC
#################################################

echo "Verificando OCC..."

occ status

#################################################
# 1. CONFIG GLOBAL
#################################################

occ config:system:set instancename --value="PixquiCloud"
occ config:system:set theme --value="pixqui"

#################################################
# 2. THEMING
#################################################

occ app:enable theming 2>/dev/null

occ config:app:set theming name --value="PixquiCloud"
occ config:app:set theming slogan --value="Tu nube, tu control"
occ config:app:set theming color --value="#6EA68F"
occ config:app:set theming url --value="https://pixqui.cloud"

[ -f "$IMG_DIR/logo.png" ] && \
occ theming:config logo "$IMG_DIR/logo.png"

[ -f "$IMG_DIR/logo.png" ] && \
occ theming:config logoheader "$IMG_DIR/logo.png"

[ -f "$IMG_DIR/favicon.ico" ] && \
occ theming:config favicon "$IMG_DIR/favicon.ico"

[ -f "$BG_DIR/pixqui-background.webp" ] && \
occ theming:config background "$BG_DIR/pixqui-background.webp"

#################################################
# 3. MAINTENANCE MODE
#################################################

echo "Activando maintenance mode..."

occ maintenance:mode --on

#################################################
# 4. LOGOS CORE
#################################################

echo "Actualizando logos core..."

[ -f "$IMG_DIR/logo.svg" ] && \
runweb cp "$IMG_DIR/logo.svg" "$NC_ROOT/core/img/logo.svg"

[ -f "$IMG_DIR/logo.svg" ] && \
runweb cp "$IMG_DIR/logo.svg" "$NC_ROOT/core/img/logo-icon.svg"

[ -f "$IMG_DIR/favicon.ico" ] && \
runweb cp "$IMG_DIR/favicon.ico" "$NC_ROOT/core/img/favicon.ico"

#################################################
# 5. LIMPIAR SKELETON
#################################################

echo "Limpiando skeleton..."

runweb rm -f "$NC_ROOT/core/skeleton/Reasons to use Nextcloud.pdf"
runweb rm -f "$NC_ROOT/core/skeleton/Nextcloud Manual.pdf"
runweb rm -f "$NC_ROOT/core/skeleton/Readme.md"
runweb rm -f "$NC_ROOT/core/skeleton/Nextcloud intro.mp4"
runweb rm -f "$NC_ROOT/core/skeleton/Nextcloud.png"
runweb rm -f "$NC_ROOT/core/skeleton/Templates credits.md"

runweb rm -f "$NC_ROOT/core/skeleton/Documents/Readme.md"
runweb rm -f "$NC_ROOT/core/skeleton/Documents/Nextcloud flyer.pdf"
runweb rm -f "$NC_ROOT/core/skeleton/Documents/Welcome to Nextcloud Hub.docx"
runweb rm -f "$NC_ROOT/core/skeleton/Documents/Example.md"

runweb rm -f "$NC_ROOT/core/skeleton/Photos/Readme.md"

runweb rm -rf "$NC_ROOT/core/skeleton/Templates"

runweb mkdir -p "$NC_ROOT/core/skeleton/Documents"
runweb mkdir -p "$NC_ROOT/core/skeleton/Photos"

#################################################
# 6. LIMPIAR USUARIOS EXISTENTES
#################################################

echo "Limpiando usuarios existentes..."

for USER_DIR in "$NC_ROOT/data"/*; do

    USER=$(basename "$USER_DIR")

    # Ignorar carpetas internas
    [[ "$USER" == appdata_oc* ]] && continue
    [ "$USER" = "files_external" ] && continue
    [ "$USER" = "updater-" ] && continue

    FILES_DIR="$USER_DIR/files"

    [ -d "$FILES_DIR" ] || continue

    echo "Procesando usuario: $USER"

    #################################################
    # BORRAR ARCHIVOS DEFAULT NEXTCLOUD
    #################################################

    runweb rm -f "$FILES_DIR/Reasons to use Nextcloud.pdf"
    runweb rm -f "$FILES_DIR/Nextcloud Manual.pdf"
    runweb rm -f "$FILES_DIR/Readme.md"
    runweb rm -f "$FILES_DIR/Nextcloud intro.mp4"
    runweb rm -f "$FILES_DIR/Nextcloud.png"
    runweb rm -f "$FILES_DIR/Templates credits.md"

    runweb rm -f "$FILES_DIR/Documents/Readme.md"
    runweb rm -f "$FILES_DIR/Documents/Nextcloud flyer.pdf"
    runweb rm -f "$FILES_DIR/Documents/Welcome to Nextcloud Hub.docx"
    runweb rm -f "$FILES_DIR/Documents/Example.md"

    runweb rm -f "$FILES_DIR/Photos/Readme.md"

    #################################################
    # ELIMINAR TEMPLATE
    #################################################

    runweb rm -rf "$FILES_DIR/Templates"

    #################################################
    # CREAR ESTRUCTURA LIMPIA
    #################################################

    runweb mkdir -p "$FILES_DIR/Documents"
    runweb mkdir -p "$FILES_DIR/Photos"

done

#################################################
# 7. DESACTIVAR FIRST RUN WIZARD
#################################################

occ config:app:delete firstrunwizard show_wizard 2>/dev/null


#################################################
# 9. REPARAR
#################################################

echo "Reparando instalación..."

occ maintenance:repair

#################################################
# 10. LIMPIAR CACHE
#################################################

occ maintenance:theme:update

#################################################
# 11. DESACTIVAR MAINTENANCE
#################################################

echo "Desactivando maintenance mode..."

occ maintenance:mode --off

#################################################
# 12. REINDEXAR
#################################################

echo "Reindexando archivos..."

occ files:scan --all

#################################################
# DONE
#################################################


echo "======================================"
echo " PixquiCloud rebrand completado"
echo "======================================"
echo "Tema aplicado correctamente"
echo "Instancia: PixquiCloud"