{ config, ... }:

{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;

    options = {
      line-numbers = true;
      decorations = true;
      syntax-theme = config.programs.bat.config.theme;
    };
  };
}
