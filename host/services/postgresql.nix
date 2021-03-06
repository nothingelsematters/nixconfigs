{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;

    package = pkgs.postgresql_13;

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
      hostnossl all all 0.0.0.0/0 trust
      host all all 0.0.0.0/0 trust
    '';
  };
}
