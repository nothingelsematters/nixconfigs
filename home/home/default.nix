{ config, pkgs, vars, ... }:

with vars; {
  users.users."${username}" = {
    createHome = true;
    isNormalUser = true;
    shell = pkgs.zsh;
    hashedPassword =
      "$6$90sWr84wO2$dD5YjotjN9o5s0ou5E82R.4OQIrTMwUQt7XcsWqShH0OOZER4CHyA4QJUJTyFSkTXjzpKklDsRfpvimvdxqz1/";
    extraGroups =
      [ "wheel" "networkmanager" "audio" "video" "docker" "input" "postgres" ];
    description = username;
  };

  home-manager.users."${username}" = args:
    import ./home.nix (args // {
      inherit pkgs;
      overlays = config.nixpkgs.overlays;
    });

  systemd.services."home-manager-${username}".preStart = ''
    ${pkgs.nix}/bin/nix-env -i -E
  '';
}
