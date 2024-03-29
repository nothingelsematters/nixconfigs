{ pkgs, ... }:

{
  home.packages = [ pkgs.lab ];

  programs = {
    zsh.shellAliases = {
      gl = "lab";
      "gl.mr.o" = "lab mr browse";

      # WARN: hardcoded username
      "gl.mr.c" = ''
        () {
          echo "\\e[1;34mtitle:\\e[0m $1"
          REVIEWERS=$(
            cat $(git rev-parse --show-toplevel)/approvers.y(|a)ml |
              yq -r '.developers.users[]' |
              awk -F'@' '{ print $1 }' |
              fzf --no-preview --height ~30% --header-first --header "reviewers: " |
              awk -v ORS=' ' '{ print "-r " $1 }'
          )
          echo "\\e[1;34mreviewers:\\e[0m $REVIEWERS"
          lab mr create origin master -a s.d.naumov $REVIEWERS -m "$1" &&
            lab mr browse
        }'';

      "gl.push.mr.c" = "g.push && gl.mr.c";
    };
  };
}
