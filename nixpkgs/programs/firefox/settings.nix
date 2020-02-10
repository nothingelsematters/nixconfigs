{ config, theme, ... }:

{
  # *** Hardening cherry-picked from https:#github.com/pyllyukko/user.js *** #

  # Disable all Web 2.0 shit
  # Not disabled: ServiceWorkers
  "beacon.enabled" = false;
  "browser.send_pings" = false;
  "device.sensors.enable" = false;
  "dom.battery.enabled" = false;
  "dom.enable_performance" = false;
  "dom.enable_user_timing" = false;
  # This may actually break some sites, but I hate RMB highjacking
  "dom.event.contextmenu.enabled" = false;
  "dom.gamepad.enabled" = false;
  "dom.netinfo.enabled" = false;
  "dom.network.enabled" = false;
  "dom.telephony.enabled" = false;
  "dom.vr.enabled" = false;
  # Not working with my vibrator. 0/10 would disable again.
  "dom.vibrator.enabled" = false;
  "dom.webnotifications.enabled" = false;
  "media.webspeech.recognition.enable" = false;

  # WebRTC leaks internal IP
  "media.peerconnection.ice.default_address_only" = true;
  "media.peerconnection.ice.no_host" = true;

  # JS leaks locale
  "javascript.use_us_english_locale" = true;

  # Disable telemetry and telemetry and telemetry and...
  # How many more of this shit is there?
  "toolkit.telemetry.unified"= false;
  "toolkit.telemetry.enabled"= false;
  "toolkit.telemetry.server"= "data:,";
  "toolkit.telemetry.archive.enabled"= false;
  "toolkit.telemetry.newProfilePing.enabled"= false;
  "toolkit.telemetry.shutdownPingSender.enabled"= false;
  "toolkit.telemetry.updatePing.enabled"= false;
  "toolkit.telemetry.bhrPing.enabled"= false;
  "toolkit.telemetry.firstShutdownPing.enabled"= false;
  "toolkit.telemetry.hybridContent.enabled"= false;
  "experiments.supported" = false;
  "experiments.enabled" = false;
  "experiments.manifest.uri" = "";
  "network.allow-experiments" = false;
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;
  "browser.crashReports.unsubmittedCheck.enabled" = false;
  "datareporting.healthreport.uploadEnabled" = false;
  "datareporting.healthreport.service.enabled" = false;
  "datareporting.policy.dataSubmissionEnabled" = false;
  "browser.discovery.enabled" = false;
  "browser.selfsupport.url" = "";
  "loop.logDomains" = false;
  "browser.newtabpage.activity-stream.feeds.telemetry"= false;
  "browser.newtabpage.activity-stream.telemetry"= false;
  "browser.newtabpage.activity-stream.telemetry.ping.endpoint"= "";
  "browser.aboutHomeSnippets.updateUrl"= "";
  "browser.newtabpage.activity-stream.asrouter.providers.snippets"= "";
  "browser.newtabpage.activity-stream.disableSnippets"= true;
  "browser.newtabpage.activity-stream.feeds.snippets"= false;
  "browser.newtabpage.activity-stream.feeds.topsites" = false;
  "browser.newtabpage.activity-stream.feeds.section.topstories"= false;
  "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
  "browser.newtabpage.activity-stream.section.highlights.includePocket"= false;
  "browser.newtabpage.activity-stream.showSponsored"= false;
  "browser.newtabpage.activity-stream.feeds.discoverystreamfeed"= false;
  "browser.newtabpage.activity-stream.showSearch" = true;
  "extensions.shield-recipe-client.enabled" = false;
  "app.shield.optoutstudies.enabled" = false;

  # Disable all sorts of auto-connections
  "network.prefetch-next" = false;
  "network.dns.disablePrefetch" = true;
  "network.dns.disablePrefetchFromHTTPS" = true;
  "network.predictor.enabled" = false;
  "browser.casting.enabled" = false;
  "media.gmp-gmpopenh264.enabled" = false;
  "media.gmp-manager.url" = "";
  "network.http.speculative-parallel-limit" = 0;
  "browser.search.update" = false;

  # Spoof referrer
  "network.http.referer.spoofSource" = true;

  # Disable third-party cookies
  "network.cookie.cookieBehavior" = 1;

  # Enable first-party isolation
  "privacy.firstparty.isolate" = true;

  # Disable built-in password manager and autofill
  "signon.rememberSignons" = false;
  "browser.formfill.enable" = false;

  # Stop communicating with Google
  # I mean, I don't use Chrome for a reason
  "geo.wifi.uri" = "https:#location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
  "browser.safebrowsing.downloads.remote.enabled" = false;

  # Disable auto-update
  "app.update.enabled" = false;

  # Disable this vulnerable clusterfuck
  "pdfjs.disabled" = true;

  # Disable annoying shit
  "browser.pocket.enabled" = false;
  "extensions.pocket.enabled" = false;

  # Enable DNT et al.
  "privacy.trackingprotection.enabled" = true;
  "privacy.trackingprotection.pbmode.enabled" = true;
  "privacy.resistFingerprinting" = true;

  # Homepage
  "browser.startup.homepage" = "duckduckgo.com";
  # Make Ctrl-Tab just switch you to the next tab
  "browser.ctrlTab.recentlyUsedOrder" = false;
  # I don't usually want to close my browser...
  "browser.tabs.closeWindowWithLastTab" = false;
  # ...but when I do, I really do
  "browser.tabs.warnOnClose" = false;
  # Dark theme.
  "lightweightThemes.selectedThemeID" = "firefox-compact-dark@mozilla.org";
  # Resume session automatically
  "browser.sessionstore.resume_session_once" = true;


  # *** end of hardening *** #

  # doesn't work with Linux
  "apz.android.chrome_fling_physics.enabled" = false;
  "browser.touchmode.auto" = false;
  "dom.keyboardevent.dispatch_during_composition" = false;
  "gfx.work-around-driver-bugs" = false;
  "layers.geometry.d3d11.enabled" = false;
  "security.family_safety.mode" = 0;

  # telemetry
  "browser.ping-centre.telemetry" = false;
  "security.certerrors.recordEventTelemetry" = false;
  "security.identitypopup.recordEventElemetry" = false;

  "security.ssl.errorReporting.enabled" = false;
  # stop accessibility services from having access to your browser
  "accessibility.force_disabled" = true;
  # unexpected Mozilla polls
  "app.normandy.enabled" = false;
  # streaming media elements to WebRTC
  "canvas.capturestream.enabled" = false;
  # turn off advices
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;

  # counts time since installation
  "app.update.checkInstallTime" = false;
  # sensor screen feature
  "apz.allow_double_tap_zooming" = false;
  # output on a screen/tv using DisplayPort
  "apz.peek_messages.enabled" = false;
  # big blue downloading arrow animation
  "browser.download.animateNotifications" = false;
  "browser.preferences.defaultPerformanceSettings.enabled" = false;
  "browser.shell.checkDefaultBrowser" = false;
  # disabling previously visited pages caching
  "browser.sessionhistory.max_total_viewers" = 0;
  # caching session and unsend messages interval
  "browser.sessionstore.interval" = 600000;
  "browser.slowStartup.notificationDisabled" = true;
  "browser.uitour.enabled" = false;
  "dom.gamepad.extensions.enabled" = false;
  # full-screen notification timeout
  "full-screen-api.warning.timeout" = 1000;

  # fonts
  "font.name.sans-serif.x-western" = "Liberation Sans";
  "font.name.serif.x-western" = "Liberation Sans";
  "font.size.fixed.x-western" = 11;
  "font.size.variable.x-western" = 11;


  # custom
  # theme related
  "svg.context-properties.content.enabled" = true;
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  # WARN username dependent
  "browser.download.dir" = "${config.home.homeDirectory}/downloads/firefox";
  "browser.uidensity" = 1;
  "browser.tabs.drawInTitlebar" = true;
  "layout.css.devPixelsPerPx" = "0.9";
  "browser.urlbar.openintab" = false;
  "browser.link.open_newwindow" = 1;
  "browser.link.open_newwindow.restriction" = 0;

  # experimental spped up
  "browser.tabs.remote.autostart" = false;
  "browser.display.show_image_placeholders" = false;
  "browser.tabs.animate" = false;
  "network.http.max-persistent-connections-per-server" = 8;
  "network.http.pipelining" = true;
  "network.http.proxy.pipelining" = true;
  "ui.submenuDelay" = 0;
  "network.dns.disableIPv6" = true;
  "nglayout.initialpaint.delay" = 0;
  "content.notify.backoffcount" = 5;
  "network.http.pipelining.maxrequests" = 8;
  "network.http.max-connections" = 96;

  "browser.aboutConfig.showWarning" = false;
  "browser.tabs.tabClipWidth" = 83;
  "materialFox.reduceTabOverflow" = true;
  "security.insecure_connection_text.enabled" = true;

  "font.name.monospace.x-western" = theme.fonts.mono;
  "browser.uiCustomization.state" = builtins.readFile ./uiCustomization.json;
  "ui.systemUsesDarkTheme" = if theme.isDark then 1 else 0;
}
