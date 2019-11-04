{ pkgs, ...}:

let
  theme = import ../../themes;
in
{
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };

    settings = {
      global = {
        monitor = 0;
        follow = "none";

        allow_markup = "yes";
        markup = "full";

        geometry = "580x5-30+10";
        shrink = false;
        indicate_hidden = "yes";
        padding = 16;
        horizontal_padding = 16;
        frame_width = 1;
        fullscreen = "delay";

        frame_color = theme.colors.text;
        separator_color = theme.colors.accent;
        font = "Fira Code 16";
        format = ''%s\n<small>%b</small>'';
        word_wrap = "yes";

        icon_position = "left";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
      };

      urgency_low = {
        background = theme.colors.primary;
        foreground = theme.colors.text;
      };

      urgency_normal = {
        background = theme.colors.primary;
        foreground = theme.colors.text;
      };

      urgency_critical = {
        background = theme.colors.primary;
        foreground = theme.colors.text;
      };

      # For functional notifications, such as volume/brightness changes
      # Displays only header to show nice centered progress bars
      func = {
        category = "func";
        format = ''<big>%b</big>'';
        fullscreen = "show";
      };
    };
  };
}
