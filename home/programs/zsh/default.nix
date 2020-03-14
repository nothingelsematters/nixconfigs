{ config, lib, pkgs, ... }:

let sources = import ../../../nix/sources.nix;
in {
  home.file.".dir_colors".source = sources.nord-dircolors + /src/dir_colors;

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
      plugins = [
        "git"
        "sudo"
        "python"
        "pip"
        "git-extras"
        "catimg"
        "colored-man-pages"
        "stack"
      ];
    };

    plugins = with pkgs; [
      {
        name = "nix-zsh-completions";
        src = nix-zsh-completions + /share/zsh/plugins/nix;
      }
      {
        name = "you-should-use";
        src = zsh-you-should-use + /share/zsh/plugins/you-should-use;
      }
      {
        name = "forgit";
        src = sources.forgit;
      }
      {
        name = "fast-syntax-highlighting";
        src = sources.fast-syntax-highlighting;
      }
    ];
    shellAliases = {
      nixx = "/etc/nixos/make.sh";
      nixxs = "nixx switch";
      nsp = "nix-shell --run zsh -p";

      confs = "z conf; atom .";

      l = "exa -lh --git";
      ll = "exa -lhT --git -L 2";
      lll = "exa -lhT --git -L 3";
      tree = "exa --tree";
      fzf = "fzf --preview 'bat --color always {}'";
      zz = "z -I";
      bd = "z -b";

      gl =
        "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)"
        + " - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)-"
        + " %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";
      gs = "git status -s";
      gmc = "gitmoji -c";

      cal = "cal -3m";

      ktr = "kotlin";
      ktc = "kotlinc";
      py = "python3";

      copy = "xclip -sel clip";
      paste = "xclip -o -sel clip";
    };

    initExtra = ''
      setopt numericglobsort   # Sort filenames numerically when it makes sense
      setopt appendhistory     # Immediately append history instead of overwriting
      setopt histignorealldups # If a new command is a duplicate, remove the older one

      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache

      source ${./forgit.plugin.zsh}

      eval "$(dircolors ~/.dir_colors)";

      if [ -n "$name" ]; then
        PROMPT="[$name] $PROMPT";
      fi

      if [ "$NIX_NAME" ]; then
          export PROMPT="[$NIX_NAME] $PROMPT";
      fi
    '';
  };
}
