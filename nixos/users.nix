{config, pkgs, ...}:

{
    users.defaultUserShell = pkgs.zsh;
    users.users.simon = {
        createHome = true;
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager" "audio"];
        description = "Simyon Empire";
    };
}
