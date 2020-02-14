{ config, pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.zsh;
    users.simon = {
      createHome = true;
      isNormalUser = true;
      extraGroups =
        [ "wheel" "networkmanager" "audio" "video" "docker" "input" ];
      description = "Simyon Empire";
    };
  };
}
