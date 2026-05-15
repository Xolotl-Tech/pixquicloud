<?php
/**
 * PixquiCloud theme – split-screen login template
 */
\OCP\Util::addScript('core', 'login', 'core');
?>
<div class="pq-login-root">

	<!-- ═══════════════════ LEFT PANEL ═══════════════════ -->
	<div class="pq-left">

		<div class="pq-left-logo">
			<img src="<?php print_unescaped(image_path('core', 'logo/logo.svg')); ?>" alt="PixquiCloud" class="pq-logo-img">
		</div>

		<div class="pq-left-body">
			<div class="pq-e2ee-badge">
				<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
				E2EE &middot; Solo tú tienes la llave
			</div>

			<h1 class="pq-hero">
				Tu nube,<br>
				<span class="pq-accent">tu control.</span>
			</h1>

			<p class="pq-hero-desc">
				PixquiCloud guarda tus archivos cifrados de extremo a extremo.
				Comparte con quien quieras, sincroniza entre dispositivos,
				y mantén tu trabajo siempre a mano &mdash; sin que nadie más pueda verlo.
			</p>

			<div class="pq-mockup" aria-hidden="true">
				<div class="pq-mockup-bar">
					<span class="pq-dot pq-dot--red"></span>
					<span class="pq-dot pq-dot--yellow"></span>
					<span class="pq-dot pq-dot--green"></span>
					<span class="pq-mockup-label">CARGANDO..</span>
					<span class="pq-mockup-progress"><span></span></span>
				</div>
				<div class="pq-mockup-lines">
					<span class="pq-line pq-line--full"></span>
					<span class="pq-line pq-line--med"></span>
					<span class="pq-line pq-line--full"></span>
					<span class="pq-line pq-line--short"></span>
					<span class="pq-line pq-line--med"></span>
				</div>
			</div>
		</div>

		<div class="pq-left-status">
			<span class="pq-status-dot"></span>
			Servicios <strong>operativos</strong> &middot; 99.98% último mes &middot; <span>verificado hace 2 min</span>
		</div>
	</div>

	<!-- ═══════════════════ RIGHT PANEL ═══════════════════ -->
	<div class="pq-right">

		<div class="pq-right-topnav">
			<a href="#">¿Necesitas ayuda?</a>
			<span class="pq-nav-sep">&bull;</span>
			<a href="#">Estado del servicio</a>
			<span class="pq-nav-sep">&bull;</span>
			<span class="pq-nav-lang">ES &middot; EN</span>
		</div>

		<div class="pq-right-body">
			<p class="pq-breadcrumb">pixqui.cloud <span>/</span> <strong>iniciar-sesión</strong></p>

			<h2 class="pq-welcome">Bienvenido<br><span class="pq-welcome-line2">de vuelta</span></h2>

			<p class="pq-welcome-sub">
				Tu nube, cifrada de extremo a extremo.
				<span class="pq-welcome-sub-link">Inicia sesión</span> para continuar.
			</p>

			<!-- Vue login app mounts here -->
			<div id="login"></div>
		</div>

		<footer class="pq-right-footer">
			&copy; 2026 PixquiCloud
			<a href="#">Términos</a>
			<a href="#">Privacidad</a>
			<a href="#">Seguridad</a>
		</footer>
	</div>

</div>
