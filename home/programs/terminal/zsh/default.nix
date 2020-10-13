{ pkgs, ... }:

{
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
        name = "fast-syntax-highlighting";
        src = zsh-fast-syntax-highlighting + /share/zsh/site-functions;
      }
      {
        name = "command-time";
        src = zsh-command-time + /share/zsh/plugins/command-time;
      }
      {
        name = "forgit";
        src = forgit;
      }
    ];

    shellAliases = rec {
      nixx = "sudo /etc/nixos/make.sh";
      nixxs = "${nixx} switch";
      nsp = "cached-nix-shell --run zsh -p";

      confs = "z conf; $EDITOR .";

      l = "exa -lh --git";
      ll = "exa -lhT --git -L 2";
      lll = "exa -lhT --git -L 3";
      tree = "exa --tree";
      zz = "z -I";
      bd = "z -b";

      gl =
        "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)"
        + " - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)-"
        + " %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";
      gs = "git status -s";
      gmc = "gitmoji -c";

      cal = "cal -3m";

      kt = "kotlin";
      ktc = "kotlinc";
      kts = "kotlinc -script";
      py = "python3";

      copy = "wl-copy";
      paste = "wl-paste";
    };

    initExtra = ''
      setopt numericglobsort   # Sort filenames numerically when it makes sense
      setopt appendhistory     # Immediately append history instead of overwriting
      setopt histignorealldups # If a new command is a duplicate, remove the older one

      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache

      eval ''${${pkgs.thefuck} --alias}

      if [ -n "$name" ]; then
        PROMPT="[$name] $PROMPT";
      fi

      if [ "$NIX_NAME" ]; then
          export PROMPT="[$NIX_NAME] $PROMPT";
      fi
    '';
  };
}
