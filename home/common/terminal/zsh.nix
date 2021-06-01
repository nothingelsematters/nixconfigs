{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [ thefuck mdcat ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = false;
      ignoreDups = false;
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
        name = "forgit";
        src = inputs.forgit;
      }
    ];

    shellAliases = rec {
      nsp = "cached-nix-shell --run zsh -p";

      l = "exa -lh --no-user --group-directories-first";
      lg = "l --git";
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
    };

    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
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
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[3~" delete-char

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
