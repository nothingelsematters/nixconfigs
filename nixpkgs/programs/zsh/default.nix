{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.z-lua ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = false;
      ignoreDups = false;
    };

    oh-my-zsh = {
      enable = true;
      theme = "half-life";
      plugins = [ "git" "sudo" "python" "pip" "git-extras" "catimg" "colored-man-pages" ];
    };

    plugins = with pkgs; [
      {
        name = "nix-zsh-completions";
        src = nix-zsh-completions + "/share/zsh/plugins/nix";
      }
      {
        name = "you-should-use";
        src = zsh-you-should-use + "/share/zsh/plugins/you-should-use";
      }
      {
        name = "fzf-git";
        src = fetchFromGitHub {
          owner = "hschne";
          repo = "fzf-git";
          rev = "bb1febcac3af711e09150849157e0726056acef9";
          sha256 = "0rva5n58pa5awnz21vmrvdjar7va9jz2802y8wd553m0fa2nv4xf";
        };
      }
      {
        name = "forgit";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "1.1.0";
          sha256 = "0vv03y5gz944ri56z6j775ngp5gc5ikav2k6q4vbhs83k0zpnpsr";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
        };
      }
    ];

    shellAliases = {
      hms = "home-manager switch";
      nrs = "sudo nixos-rebuild switch";
      nsp = "nix-shell --run zsh -p";
      npd = "nix-channel --update && hms";

      homed = "nano ~/.config/nixpkgs/home.nix";
      confed = "sudo nano /etc/nixos/configuration.nix";
      confs = "z conf; atom .";

      l = "exa -lh --git";
      ll = "exa -lhT --git -L 2";
      lll = "exa -lhT --git -L 3";
      tree = "exa --tree";
      fzf = "fzf --preview 'bat --color always {}'";
      zz = "z -I";
      bd = "z -b";

      gl = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)"
        + " - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)-"
        + " %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";
      gs = "git status -s";
      gmc = "gitmoji -c";

      cal = "cal -3m";

      ktr = "kotlin";
      ktc = "kotlinc";

      copy = "xclip -sel clip";
      paste = "xclip -o -sel clip";
    };

    initExtra =
      ''
      setopt numericglobsort   # Sort filenames numerically when it makes sense
      setopt appendhistory     # Immediately append history instead of overwriting
      setopt histignorealldups # If a new command is a duplicate, remove the older one

      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache

      eval "$(dircolors ~/.dir_colors)";

      eval "$(z --init zsh enhanced once fzf)"
      export _ZL_ECHO=1

      if [ -n "$name" ]; then
        PROMPT="[$name] $PROMPT";
      fi

      if [ "$NIX_NAME" ]; then
          export PROMPT="[$NIX_NAME] $PROMPT";
      fi
      '';
  };
}
