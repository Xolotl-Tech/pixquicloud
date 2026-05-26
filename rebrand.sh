#!/bin/bash
# PixquiCloud rebrand script
NC_ROOT="/www/wwwroot/app.pixqui.cloud"
PHP="/www/server/php/83/bin/php"
IMG_DIR="$NC_ROOT/themes/pixqui/core/img/logo"
BG_DIR="$NC_ROOT/themes/pixqui/core/img/background"

echo "Aplicando rebrand PixquiCloud..."

# 1. Config del sistema
$PHP "$NC_ROOT/occ" config:system:set instancename --value="PixquiCloud"
$PHP "$NC_ROOT/occ" config:system:set theme --value="pixqui"

# 2. Theming app
$PHP "$NC_ROOT/occ" app:enable theming 2>/dev/null
$PHP "$NC_ROOT/occ" config:app:set theming name --value="PixquiCloud"
$PHP "$NC_ROOT/occ" config:app:set theming slogan --value="Tu nube, tu control"
$PHP "$NC_ROOT/occ" config:app:set theming color --value="#6EA68F"
$PHP "$NC_ROOT/occ" config:app:set theming url --value="https://pixqui.cloud"
[ -f "$IMG_DIR/logo.png" ] && $PHP "$NC_ROOT/occ" theming:config logo "$IMG_DIR/logo.png"
[ -f "$IMG_DIR/logo.png" ] && $PHP "$NC_ROOT/occ" theming:config logoheader "$IMG_DIR/logo.png"
[ -f "$IMG_DIR/favicon.ico" ] && $PHP "$NC_ROOT/occ" theming:config favicon "$IMG_DIR/favicon.ico"
[ -f "$BG_DIR/pixqui-background.webp" ] && $PHP "$NC_ROOT/occ" theming:config background "$BG_DIR/pixqui-background.webp"

# 3. Copiar logo al core
[ -f "$IMG_DIR/logo.svg" ] && cp "$IMG_DIR/logo.svg" "$NC_ROOT/core/img/logo.svg"
[ -f "$IMG_DIR/logo.svg" ] && cp "$IMG_DIR/logo.svg" "$NC_ROOT/core/img/logo-icon.svg"
[ -f "$IMG_DIR/favicon.ico" ] && cp "$IMG_DIR/favicon.ico" "$NC_ROOT/core/img/favicon.ico"

# 4. Strings
sed -i 's/Nextcloud/PixquiCloud/g' "$NC_ROOT/apps/firstrunwizard/l10n/es.js"
sed -i 's/Nextcloud/PixquiCloud/g' "$NC_ROOT/apps/firstrunwizard/l10n/es_MX.js"
sed -i 's/Nextcloud Hub/PixquiCloud/g' "$NC_ROOT/lib/private/Server.php" 2>/dev/null
sed -i 's/Nextcloud Hub/PixquiCloud/g' "$NC_ROOT/version.php" 2>/dev/null
sed -i 's/Nextcloud Hub/PixquiCloud/g' "$NC_ROOT/apps/settings/templates/settings/admin/overview.php" 2>/dev/null
$PHP "$NC_ROOT/occ" config:app:delete firstrunwizard show_wizard

# 5. Limpiar caché
$PHP "$NC_ROOT/occ" maintenance:repair

echo "Rebrand completo. PixquiCloud listo."
