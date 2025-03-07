{ pkgs, ... }:

{
  home.packages = [ pkgs.ripgrep ];
  programs.zsh.shellAliases."rg.fzf" = ''
    rg --line-number --with-filename . --color=always --field-match-separator ' ' \
    | fzf --ansi --preview 'bat --color=always {1} --highlight-line {2}' --preview-window ~3,+{2}-20
  '';
}
