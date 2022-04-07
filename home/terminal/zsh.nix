{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = false;
      ignoreDups = false;
    };

    plugins = with pkgs; [
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

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
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
      compinit -u

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
      bindkey "^[f" forward-word
      bindkey "^[b" backward-word
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word
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
