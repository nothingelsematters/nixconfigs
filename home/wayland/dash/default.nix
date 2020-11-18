{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nixpkgs-wayland.wldash ];

  lib.packages.launcher = rec {
    name = "wldash";
    cmd = name;
    package = pkgs.nixpkgs-wayland.wldash;
  };

  xdg.configFile."wldash/config.json".text = builtins.toJSON {
    outputMode = "active";
    scale = 2;
    fonts = with config.lib.theme.fonts; {
      mono = mono.name;
      sans = gtk.name;
    };

    background = {
      red = 0.0;
      green = 0.0;
      blue = 0.0;
      opacity = 0.8;
    };

    widget.margin = {
      margins = [ 1560 20 20 910 ];
      widget.verticalLayout = [
        {
          horizontalLayout = [
            {
              margin = {
                margins = [ 0 88 0 32 ];
                widget = {
                  verticalLayout = [
                    {
                      date = {
                        font = null;
                        font_size = 32.0;
                      };
                    }
                    {
                      clock = {
                        font = null;
                        font_size = 128.0;
                      };
                    }
                  ];
                };
              };
            }
            {
              verticalLayout = [
                {
                  margin = {
                    margins = [ 0 0 0 8 ];
                    widget.battery = {
                      font = "mono";
                      font_size = 24.0;
                      length = 0;
                    };
                  };
                }
                {
                  margin = {
                    margins = [ 0 0 0 8 ];
                    widget.backlight = {
                      device = "intel_backlight";
                      font = null;
                      font_size = 24.0;
                      length = 0;
                    };
                  };
                }
                {
                  margin = {
                    margins = [ 0 0 0 8 ];
                    widget.pulseAudio = {
                      font = null;
                      font_size = 24.0;
                      length = 0;
                    };
                  };
                }
              ];
            }
          ];
        }
        {
          calendar = {
            font_primary = null;
            font_secondary = null;
            font_size = 15.0;
            sections = 3;
          };
        }
        {
          launcher = {
            font = "mono";
            font_size = 32.0;
            length = 0;
            app_opener = "";
            term_opener = "";
            url_opener = "";
          };
        }
      ];
    };
  };
}
