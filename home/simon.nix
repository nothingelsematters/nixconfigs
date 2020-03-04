{ config, pkgs, ... }:

{
  users.users.simon = {
    createHome = true;
    isNormalUser = true;
    hashedPassword =
      "$6$90sWr84wO2$dD5YjotjN9o5s0ou5E82R.4OQIrTMwUQt7XcsWqShH0OOZER4CHyA4QJUJTyFSkTXjzpKklDsRfpvimvdxqz1/";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "input" ];
    description = "Simyon Empire";
  };

  home-manager.users.simon = args:
    import ./home.nix (args // { inherit pkgs; });
}
