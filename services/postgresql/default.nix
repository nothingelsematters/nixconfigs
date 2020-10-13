{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;

    package = pkgs.postgresql_12;

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
  };
}
