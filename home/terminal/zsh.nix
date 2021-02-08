{ pkgs, ... }:

{
  home.packages = [ pkgs.thefuck ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = false;
      ignoreDups = false;
    };

    # oh-my-zsh = {
    #   enable = true;
    #   theme = "half-life";
    #   plugins = [
    #     "git"
    #     "sudo"
    #     "python"
    #     "pip"
    #     "git-extras"
    #     "catimg"
    #     "colored-man-pages"
    #     "stack"
    #   ];
    # };

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
        name = "forgit";
        src = forgit;
      }
    ];

    shellAliases = rec {
      nixx = "sudo /etc/nixos/make.sh";
      nixxs = "${nixx} switch";
      nsp = "cached-nix-shell --run zsh -p";

      confs = "z conf; $EDITOR .";

      l = "exa -lh --git --group-directories-first";
      la = "l -a";
      tree = "l -T";
      ll = "tree -L 2";
      lll = "tree -L 3";
      zz = "z -I";
      bd = "z -b";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      cal = "cal -3m";

      copy = "wl-copy";
      paste = "wl-paste";
    };

    initExtra = ''
      setopt numericglobsort   # Sort filenames numerically when it makes sense
      setopt appendhistory     # Immediately append history instead of overwriting
      setopt histignorealldups # If a new command is a duplicate, remove the older one
      setopt autocd autopushd  # Implied cd
      autoload -U compinit     # Completion
      compinit

      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache

      # Fuzzy completions
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric
      zstyle -e ':completion:*:approximate:*' \
              max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
      bindkey '^[[A' up-line-or-search
      bindkey '^[[B' down-line-or-search

      eval $(${pkgs.thefuck}/bin/thefuck --alias)

      if [ -n "$name" ]; then
        PROMPT="[$name] $PROMPT";
      fi

      if [ "$NIX_NAME" ]; then
          export PROMPT="[$NIX_NAME] $PROMPT";
      fi

      wifi() {
        nmcli d wifi connect $(nmcli d wifi list --rescan yes | rg $0 | gawk '{ print $1 }')
      }
    '';
  };
}
