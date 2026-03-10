{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];

    settings = {
      enter_accept = true;
      invert = true;
      style = "compact";
    };
  };
}
