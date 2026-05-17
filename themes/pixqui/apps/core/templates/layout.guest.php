<?php
/**
 * PixquiCloud theme – login guest layout override
 * Replaces the default Nextcloud guest wrapper with a full-screen structure
 * that allows the split-screen login design.
 */
?>
<!DOCTYPE html>
<html class="ng-csp" data-placeholder-focus="false" lang="<?php p($_['language']); ?>" data-locale="<?php p($_['locale']); ?>" translate="no">
	<head
	<?php if ($_['user_uid']) { ?>
		data-user="<?php p($_['user_uid']); ?>" data-user-displayname="<?php p($_['user_displayname']); ?>"
	<?php } ?>
	 data-requesttoken="<?php p($_['requesttoken']); ?>">
		<meta charset="utf-8">
		<title><?php p(!empty($_['pageTitle']) ? $_['pageTitle'] . ' – ' : ''); p($theme->getTitle()); ?></title>
		<meta name="csp-nonce" nonce="<?php p($_['cspNonce']); /* Do not pass into "content" to prevent exfiltration */ ?>">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
		<meta name="theme-color" content="<?php p($theme->getColorPrimary()); ?>">
		<link rel="icon" href="<?php print_unescaped(image_path('core', 'favicon.ico')); ?>">
		<link rel="apple-touch-icon" href="<?php print_unescaped(image_path('core', 'favicon-touch.png')); ?>">
		<link rel="mask-icon" sizes="any" href="<?php print_unescaped(image_path('core', 'favicon-mask.svg')); ?>" color="<?php p($theme->getColorPrimary()); ?>">
		<link rel="manifest" href="<?php print_unescaped(image_path('core', 'manifest.json')); ?>" crossorigin="use-credentials">
		<?php emit_css_loading_tags($_); ?>
		<?php emit_script_loading_tags($_); ?>
		<?php print_unescaped($_['headers']); ?>
	</head>
	<body id="<?php p($_['bodyid']); ?>" <?php foreach ($_['enabledThemes'] as $themeId) {
		p("data-theme-$themeId ");
	} ?> data-themes="<?php p(join(',', $_['enabledThemes'])) ?>">
		<?php include \OC::$SERVERROOT . '/core/templates/layout.noscript.warning.php'; ?>
		<?php include \OC::$SERVERROOT . '/core/templates/layout.initial-state.php'; ?>
		<?php print_unescaped($_['content']); ?>
	</body>
</html>