{ config, pkgs, ... }:

let
  files = "rg --files";
  preview = [ "--preview 'exa --tree {} | head -100'" ];
in {
  programs.fzf = {
    enable = true;
    defaultOptions = [ "-m" "--reverse" "--preview 'bat --color always {}'" ];
    defaultCommand = files;
    fileWidgetCommand = files;
    fileWidgetOptions = preview;
    changeDirWidgetOptions = preview;
  };
}
