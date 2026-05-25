#!/bin/bash

###############################################################################
# PixquiCloud Rebrand Script
# Elimina archivos por defecto de Nextcloud para rebranding
###############################################################################

set -e

NEXTCLOUD_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🎨 Iniciando proceso de rebranding PixquiCloud..."
echo "📍 Directorio: $NEXTCLOUD_DIR"

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# === SKELETON (archivos plantilla para nuevos usuarios) ===
echo -e "\n${YELLOW}[1/3]${NC} Limpiando skeleton (archivos plantilla)..."

SKELETON_PATH="$NEXTCLOUD_DIR/core/skeleton"

if [ -d "$SKELETON_PATH" ]; then
    # Eliminar PDFs por defecto
    rm -f "$SKELETON_PATH/Reasons to use Nextcloud.pdf"
    rm -f "$SKELETON_PATH/Nextcloud Manual.pdf"
    echo -e "${GREEN}✓${NC} PDFs eliminados del skeleton"
    
    # Eliminar archivos de bienvenida
    rm -f "$SKELETON_PATH/Readme.md"
    rm -f "$SKELETON_PATH/Documents/Readme.md"
    rm -f "$SKELETON_PATH/Documents/Nextcloud flyer.pdf"
    rm -f "$SKELETON_PATH/Documents/Welcome to Nextcloud Hub.docx"
    echo -e "${GREEN}✓${NC} Archivos de bienvenida eliminados"
    
    # Eliminar Readme de Photos y Templates
    rm -f "$SKELETON_PATH/Photos/Readme.md"
    rm -f "$SKELETON_PATH/Templates/Readme.md"
    echo -e "${GREEN}✓${NC} README files de carpetas especiales eliminados"
else
    echo -e "${RED}✗${NC} No se encontró: $SKELETON_PATH"
fi

# === DATA USERS (eliminar archivos de usuarios existentes) ===
echo -e "\n${YELLOW}[2/3]${NC} Limpiando archivos de usuarios existentes..."

DATA_PATH="$NEXTCLOUD_DIR/data"

if [ -d "$DATA_PATH" ]; then
    # Buscar y eliminar archivos por defecto en todas las carpetas de usuario
    find "$DATA_PATH" -type f -name "Reasons to use Nextcloud.pdf" -delete
    find "$DATA_PATH" -type f -name "Nextcloud Manual.pdf" -delete
    find "$DATA_PATH" -type f -name "Nextcloud flyer.pdf" -delete
    find "$DATA_PATH" -type f -name "Welcome to Nextcloud Hub.docx" -delete
    echo -e "${GREEN}✓${NC} Archivos por defecto eliminados de usuarios"
    
    # Eliminar Readme.md de usuarios (excepto backups)
    find "$DATA_PATH" -type f -path "*/files/Readme.md" ! -path "*/backups/*" -delete
    find "$DATA_PATH" -type f -path "*/files/Documents/Readme.md" ! -path "*/backups/*" -delete
    find "$DATA_PATH" -type f -path "*/files/Photos/Readme.md" ! -path "*/backups/*" -delete
    find "$DATA_PATH" -type f -path "*/files/Templates/Readme.md" ! -path "*/backups/*" -delete
    echo -e "${GREEN}✓${NC} README files eliminados de usuarios"
else
    echo -e "${YELLOW}⚠${NC} No se encontró carpeta data: $DATA_PATH"
fi

# === APPS (eliminar archivos de intro de apps) ===
echo -e "\n${YELLOW}[3/3]${NC} Limpiando archivos de apps..."

APPS_PATH="$NEXTCLOUD_DIR/apps"

# Eliminar tutoriales de firstrunwizard si existe
if [ -d "$APPS_PATH/firstrunwizard" ]; then
    find "$APPS_PATH/firstrunwizard" -type f \( -name "*.pdf" -o -name "*welcome*" -o -name "*intro*" \) -delete 2>/dev/null || true
    echo -e "${GREEN}✓${NC} Archivos de introducción de firstrunwizard eliminados"
fi

# Eliminar recursos por defecto de otros archivos
if [ -d "$APPS_PATH" ]; then
    find "$APPS_PATH" -type f -name "*Nextcloud*" ! -path "*/vendor/*" -delete 2>/dev/null || true
fi

echo -e "${GREEN}✓${NC} Limpieza de apps completada"

# === SUMMARY ===
echo -e "\n${GREEN}✅ Rebranding completado exitosamente!${NC}"
echo -e "\n📋 Resumen de cambios:"
echo -e "  • Archivos plantilla (skeleton) limpiados"
echo -e "  • Archivos de usuarios existentes limpiados"
echo -e "  • Archivos de introducción removidos"
echo -e "  • La próxima vez que se agreguen usuarios verán solo archivos PixquiCloud"
echo ""
