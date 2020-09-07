{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
