{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.expireDuplicatesFirst = false;
    history.ignoreDups = false;

    oh-my-zsh = {
      enable = true;
      theme = "norm";
      plugins = [ "git" "sudo" "python" "pip" "git-extras" "catimg" ];
    };

    shellAliases = {
      l = "exa -lh --git";
      ll = "exa -lhT --git -L 2";
      lll = "exa -lhT --git -L 3";
      tree = "exa --tree";

      hms = "home-manager switch";
      nrs = "sudo nixos-rebuild switch";

      homed = "nano ~/.config/nixpkgs/home.nix";
      confed = "sudo nano /etc/nixos/configuration.nix";

      bat = "bat --paging never";
      nsp = "nix-shell -p";

      gl = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";
      gs = "git status -s";
    };

    initExtra =
      ''
      setopt numericglobsort   # Sort filenames numerically when it makes sense
      setopt appendhistory     # Immediately append history instead of overwriting
      setopt histignorealldups # If a new command is a duplicate, remove the older one

      transfer() {
        if [ $# -eq 0 ]; then
          echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
          return 1;
        fi
        tmpfile=$( mktemp -t transferXXX );
        if tty -s; then
          basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
          curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
        else
          curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
        fi;
          cat $tmpfile | xclip;
          cat $tmpfile;
          echo;
          rm -f $tmpfile;
      }

      nemacs() {
        if [ -n "$name" ]; then
          emacs --name "[in $name] Emacs" . &;
          disown;
        else
          echo "Not in nix-shell!";
        fi
      }

      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.zsh/cache

      eval "$(dircolors ~/.dir_colors)";

      if [ -n "$name" ]; then
        PROMPT="[$name] $PROMPT";
      fi

      . ${pkgs.autojump}/share/autojump/autojump.zsh
      '';
    };

}
