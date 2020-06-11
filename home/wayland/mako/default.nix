{ config, ... }:

with config.lib; {
  programs.mako = {
    enable = true;

    anchor = "top-right";
    layer = "overlay";
    margin = "3,5";
    height = 100;
    width = 320;
    textColor = theme.colors.text.primary;

    backgroundColor = theme.colors.background.secondary;
    borderColor = theme.colors.text.secondary;
    borderRadius = 4;
    borderSize = 2;

    defaultTimeout = 10000;
    font = "${theme.fonts.notification} 9";
    format = "%s\\n<small>%b</small>";

    iconPath = "${theme.notification-icons.package}/share/icons/Paper";
    icons = true;
    maxIconSize = 32;
    maxVisible = 5;
    sort = "+time";
  };
}
