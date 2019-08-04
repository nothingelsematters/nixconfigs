{config, pkgs, ...}:

{
  users = {
    defaultUserShell = pkgs.zsh;
    users.simon = {
      createHome = true;
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "docker"];
      description = "Simyon Empire";
    };
  };
}
