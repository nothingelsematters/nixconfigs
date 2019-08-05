{ config, pkgs, ... }:

let
    theme = import ../../themes;
    userContent = ''
        ${theme.toCss}
        ${builtins.readFile ./userContent.css}
    '';
    userChrome = ''
        ${theme.toCss}
        ${builtins.readFile ./userChrome.css}
    '';
in {
  home.file.userContent = {
    text = userContent;
    target = ".mozilla/firefox/default/chrome/userContent.css";
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        isDefault = true;

        # Hardening cherry-picked from https://github.com/pyllyukko/user.js
        settings = {
          # Disable all Web 2.0 shit
          # Not disabled: ServiceWorkers
          "beacon.enabled" = false;
          "browser.send_pings" = false;
          "device.sensors.enable" = false;
          "dom.battery.enabled" = false;
          "dom.enable_performance" = false;
          "dom.enable_user_timing" = false;
          "dom.event.contextmenu.enabled" = false; # This may actually break some sites, but I hate RMB highjacking
          "dom.gamepad.enabled" = false;
          "dom.netinfo.enabled" = false;
          "dom.network.enabled" = false;
          "dom.telephony.enabled" = false;
          "dom.vr.enabled" = false;
          "dom.vibrator.enabled" = false; # Not working with my vibrator. 0/10 would disable again.
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
          "geo.wifi.uri" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
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


          # end of copy-paste, my own changes

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
          # disk cache size
          "browser.cache.disk.smart_size.enabled" = false;
          "browser.cache.disk.capacity" = 102400;

          # fonts
          "font.name.monospace.x-western" = "Fantasque Sans Mono";
          "font.name.sans-serif.x-western" = "Liberation Sans";
          "font.name.serif.x-western" = "Liberation Sans";
          "font.size.fixed.x-western" = 11;
          "font.size.variable.x-western" = 11;

          "browser.download.dir" = "/home/simon/downloads/firefox"; # WARN username dependent
          "browser.uiCustomization.state" =
            "{\
                \"placements\":\
                    {\
                        \"widget-overflow-fixed-list\": [],\
                        \"nav-bar\":\
                            [\
                                \"back-button\",\
                                \"forward-button\",\
                                \"stop-reload-button\",\
                                \"home-button\",\
                                \"customizableui-special-spring1\",\
                                \"urlbar-container\",\
                                \"customizableui-special-spring2\",\
                                \"downloads-button\",\
                                \"developer-button\",\
                                \"fxa-toolbar-menu-button\"\
                            ],\
                        \"toolbar-menubar\": [\"menubar-items\"],\
                        \"TabsToolbar\":\
                            [\
                                \"tabbrowser-tabs\",\
                                \"new-tab-button\",\
                                \"alltabs-button\"\
                            ],\
                        \"PersonalToolbar\": [\"personal-bookmarks\"]\
                    },\
                \"seen\":\
                    [\
                        \"developer-button\",\
                        \"enhancerforyoutube_maximerf_addons_mozilla_org-browser-action\",\
                        \"_b3792611-d72c-4251-9a50-0f072f4f3e98_-browser-action\",\
                        \"jid1-zadieub7xozojw_jetpack-browser-action\",\
                        \"_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action\",\
                        \"_85860b32-02a8-431a-b2b1-40fbd64c9c69_-browser-action\",\
                        \"_e7fefcf3-b39c-4f17-5215-ebfe120a7031_-browser-action\",\
                        \"_a94d60a0-8408-4c53-8eec-cb349eb958b8_-browser-action\",\
                        \"_5a87a431-47c5-4ccf-96dc-228c87d2d146_-browser-action\",\
                        \"webide-button\"\
                    ],\
                \"dirtyAreaCache\":\
                    [\
                        \"nav-bar\",\
                        \"toolbar-menubar\",\
                        \"TabsToolbar\",\
                        \"PersonalToolbar\",\
                        \"widget-overflow-fixed-list\"\
                    ],\
                \"currentVersion\": 16,\
                \"newElementCount\": 7\
            }";

          "browser.uidensity" = 1;
          "browser.tabs.drawInTitlebar" = true;
          "layout.css.devPixelsPerPx" = "0.9";
        };
        # UI styling
        userChrome = userChrome;
      };
    };
  };
}
