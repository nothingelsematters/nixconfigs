let
  files = "rg --files";
  preview = [''
    --preview \"sh -c 'if [ -d {} ]; \
        then exa -T {} | head -100; \
        else bat --color always {}; \
      fi'\"''];
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
