let
  files = "rg --files";
  preview = [''
    --preview \"if [ -d {} ]; \
        then eza --color always --icons --tree --level 2 {}; \
        else bat --color always {}; \
      fi\"
  ''];
in {
  programs.fzf = {
    enable = true;
    defaultOptions = [ "-m" "--reverse" ] ++ preview;
    defaultCommand = files;
    fileWidgetCommand = files;
    fileWidgetOptions = preview;
    changeDirWidgetOptions = preview;
  };
}
