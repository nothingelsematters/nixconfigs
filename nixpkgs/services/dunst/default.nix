{ pkgs, ...}:

let
  theme = import ../../theme { inherit pkgs; };
in
{
  services.dunst = {
    enable = true;
    iconTheme = theme.notification-icons;

    settings = {
      global = {
        monitor = 0;
        follow = "none";

        allow_markup = "yes";
        markup = "full";
        transparency = 12;

        geometry = "400x5-5+30";
        shrink = false;
        indicate_hidden = "yes";
        padding = 10;
        horizontal_padding = 10;
        frame_width = 0;
        fullscreen = "delay";

        frame_color = theme.colors.background.accent;
        separator_color = theme.colors.background.secondary;
        font = theme.fonts.notification + " 10";
        format = ''%s\n<small>%b</small>'';
        word_wrap = "yes";

        icon_position = "left";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
      };

      urgency_low = {
        background = theme.colors.background.secondary;
        foreground = theme.colors.text.primary;
      };

      urgency_normal = {
        background = theme.colors.background.secondary;
        foreground = theme.colors.text.primary;
      };

      urgency_critical = {
        background = theme.colors.background.secondary;
        foreground = theme.colors.text.urgent;
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
