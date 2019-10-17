{ config, lib, pkgs, ... }:

{
  home.file.zlua = {
    text = builtins.readFile (
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/skywind3000/z.lua/master/z.lua";
        sha256 = "0sbgiygi3k91ynj80pvmmh0vrglfzckd5zxdk6hv6z0ivgzs5yki";
      }
    );
    target = ".local/share/z.lua/z.lua";
    executable = true;
  };

  home.packages = [ pkgs.lua ];

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

    plugins = [
      {
        # ga  - Interactive git add selector
        # glo - Interactive git log viewer
        # gi  - Interactive .gitignore generator
        # gd  - Interactive git diff viewer
        # gcf - Interactive git checkout <file> selector
        # gss - Interactive git stash viewer
        # gclean - Interactive git clean selector

        name = "forgit";
        src = pkgs.fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "1.1.0";
          sha256 = "0vv03y5gz944ri56z6j775ngp5gc5ikav2k6q4vbhs83k0zpnpsr";
        };
      }
      {
        name = "diff-so-fancy";
        src = pkgs.fetchFromGitHub {
          owner = "so-fancy";
          repo = "diff-so-fancy";
          rev = "v1.2.5";
          sha256 = "1jqq7zd75aypxchrq0vjcw5gyn3wyjqy6w79mq2lzky8m6mqn8vr";
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

      l = "exa -lh --git";
      ll = "exa -lhT --git -L 2";
      lll = "exa -lhT --git -L 3";
      tree = "exa --tree";
      fzf = "fzf --preview 'bat --color always {}'";
      zz = "z -I";
      bd = "z -b";

      gl = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";
      gs = "git status -s";

      cal = "cal -3m";
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

      eval "$(${pkgs.lua}/bin/lua ~/.local/share/z.lua/z.lua --init zsh enhanced once fzf)"
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
