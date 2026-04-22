#!/bin/bash
# PixquiCloud rebrand script
# Correr después de cada: php occ upgrade

NC_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IMG_DIR="$NC_ROOT/themes/pixqui/core/img/logo"
BG_DIR="$NC_ROOT/themes/pixqui/core/img/background"

echo "Aplicando rebrand PixquiCloud..."

# 1. Config del sistema
php "$NC_ROOT/occ" config:system:set instancename --value="PixquiCloud"
php "$NC_ROOT/occ" config:system:set theme --value="pixqui"

# 2. Theming app
php "$NC_ROOT/occ" app:enable theming 2>/dev/null
php "$NC_ROOT/occ" config:app:set theming name --value="PixquiCloud"
php "$NC_ROOT/occ" config:app:set theming slogan --value="Tu nube, tu control"
php "$NC_ROOT/occ" config:app:set theming color --value="#6EA68F"
php "$NC_ROOT/occ" config:app:set theming url --value="https://pixqui.cloud"
[ -f "$IMG_DIR/logo.png" ] && php "$NC_ROOT/occ" theming:config logo "$IMG_DIR/logo.png"
[ -f "$IMG_DIR/logo.png" ] && php "$NC_ROOT/occ" theming:config logoheader "$IMG_DIR/logo.png"
[ -f "$IMG_DIR/favicon.ico" ] && php "$NC_ROOT/occ" theming:config favicon "$IMG_DIR/favicon.ico"
[ -f "$BG_DIR/pixqui-background.webp" ] && php "$NC_ROOT/occ" theming:config background "$BG_DIR/pixqui-background.webp"

# 3. Copiar logo al core
[ -f "$IMG_DIR/logo.svg" ] && cp "$IMG_DIR/logo.svg" "$NC_ROOT/core/img/logo.svg"
[ -f "$IMG_DIR/logo.svg" ] && cp "$IMG_DIR/logo.svg" "$NC_ROOT/core/img/logo-icon.svg"
[ -f "$IMG_DIR/favicon.ico" ] && cp "$IMG_DIR/favicon.ico" "$NC_ROOT/core/img/favicon.ico"

# 4. Reemplazar strings en firstrunwizard
sed -i '' 's/Nextcloud/PixquiCloud/g' "$NC_ROOT/apps/firstrunwizard/l10n/es.js"
sed -i '' 's/Nextcloud/PixquiCloud/g' "$NC_ROOT/apps/firstrunwizard/l10n/es_MX.js"
php "$NC_ROOT/occ" config:app:delete firstrunwizard show_wizard

# Reemplazar strings en core
sed -i '' 's/Nextcloud Hub/PixquiCloud/g' "$NC_ROOT/lib/private/Server.php" 2>/dev/null
sed -i '' 's/Nextcloud Hub/PixquiCloud/g' "$NC_ROOT/version.php" 2>/dev/null
sed -i '' 's/Nextcloud Hub/PixquiCloud/g' "$NC_ROOT/apps/settings/templates/settings/admin/overview.php" 2>/dev/null
# 5. Limpiar caché
php "$NC_ROOT/occ" maintenance:repair

echo "Rebrand completo. PixquiCloud listo."