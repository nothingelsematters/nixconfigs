{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ zoom-us etcd_3_4 ];

  programs = {
    zsh = {
      shellAliases.hms =
        "nix build .#work.activationPackage && ./result/activate";

      initExtra = ''
        if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
          . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    };

    git = {
      userName = "Simon Naumov";
      userEmail = "s.d.naumov@tinkoff.ru";
    };
  };
}
