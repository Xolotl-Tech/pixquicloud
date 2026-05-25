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
			<div class="pq-logo-icon">
				<img src="<?php print_unescaped(image_path('core', 'logo/logo-mark.svg')); ?>" width="22" height="22" alt="PixquiCloud">
			</div>
			<span>PixquiCloud</span>
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
					<span class="pq-mockup-label">ARCHIVOS &middot; RECIENTES</span>
				</div>
				<div class="pq-file-list">
					<div class="pq-file-item">
						<svg class="pq-file-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
						<span class="pq-file-name">Q2-roadmap.md</span>
						<span class="pq-e2ee-tag">E2EE</span>
						<span class="pq-file-star">&#9733;</span>
						<span class="pq-file-time">hace 2 min</span>
					</div>
					<div class="pq-file-item">
						<svg class="pq-file-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/></svg>
						<span class="pq-file-name">Proyecto Pol&iacute;gono</span>
						<span class="pq-e2ee-tag">E2EE</span>
						<span class="pq-file-time">ayer</span>
					</div>
					<div class="pq-file-item">
						<svg class="pq-file-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>
						<span class="pq-file-name">IMG_4521.jpg</span>
						<span class="pq-e2ee-tag">E2EE</span>
						<span class="pq-file-time">3 horas</span>
					</div>
					<div class="pq-file-item">
						<svg class="pq-file-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="23 7 16 12 23 17 23 7"/><rect x="1" y="5" width="15" height="14" rx="2"/></svg>
						<span class="pq-file-name">demo-onboarding.mp4</span>
						<span class="pq-e2ee-tag">E2EE</span>
						<span class="pq-file-time">vie</span>
					</div>
				</div>
			</div>
			
			<div class="status">
				<span class="live"></span>
				Servicios <strong>operativos</strong> &middot; 99.98% &uacute;ltimo mes &middot;
				<span>verificado hace 2 min</span>
			</div>
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
