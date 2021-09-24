{ pkgs, ... }:

{
  home.packages = with pkgs; [ mdcat ];

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

      cal = "ncal -3bM";
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

      if [ -n "$name" ]; then
        PROMPT="[$name] $PROMPT";
      fi

      if [ "$NIX_NAME" ]; then
          export PROMPT="[$NIX_NAME] $PROMPT";
      fi

      function gb() {
        current=$(git rev-parse --abbrev-ref HEAD)
        branches=("''${(@f)$(git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')}")
        for branch in $branches; do
          desc=$(git config branch.$branch.description)
          if [ $branch = $current ]; then
            branch="* \033[0;32m$branch\033[0m"
          else
            branch="  $branch"
          fi
          echo -e "$branch \033[0;36m$desc\033[0m"
        done
      }

      if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi
    '';
  };
}
