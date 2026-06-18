let
  files = "rg --files";
  preview = [
    ''
      --preview \"if [ -d {} ]; \
          then eza --color always --icons --tree --level 2 {}; \
          else bat --color always {}; \
        fi\"
    ''
  ];
in
{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "-m"
      "--reverse"
      "--preview-window 'right:50%,border-left,<80(bottom:50%,border-top)'"
    ]
    ++ preview;
    defaultCommand = files;
    fileWidgetCommand = files;
    fileWidgetOptions = preview;
    changeDirWidgetOptions = preview;
  };
}
