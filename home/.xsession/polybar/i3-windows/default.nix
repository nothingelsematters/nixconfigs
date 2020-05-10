{ pkgs, lib, ... }:

let
  theme = (import ../../../../theme { inherit pkgs lib; }).colors;
  python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]) + /bin/python3;

  addVars = with builtins;
    with lib;
    file: vars:
    let
      lines = strings.splitString "\n" (readFile file);
      size = length lines;
      notImport = x:
        !(strings.hasPrefix "import" x.fst || strings.hasPrefix "from " x.fst);
      center = (lists.findFirst notImport 0
        (lists.zipLists lines (lists.range 0 (size - 1)))).snd;
      patched = lists.sublist 0 center lines ++ [ vars ]
        ++ lists.sublist center size lines;
    in concatStringsSep "\n" patched;

  module = pkgs.writeTextFile {
    name = "module.py";
    text = addVars ./module.py ''
      focused = '${theme.text.secondary}'
      wfocused = '${theme.text.primary}'
      unfocused = '${theme.text.disabled}'
      urgent = '${theme.text.urgent}'

      empty = ''
      ICON_FONT = 3
      COMMAND = '${python} ${./command.py}'
      ICONS = [
          ('class=Firefox', ''),
          ('class=Telegram', ''),
          ('class=Slack', ''),
          ('class=Atom', ''),
          ('class=Alacritty', ''),
          ('class=kitty', ''),
          ('class=Typora', ''),
          ('class=libreoffice*', ''),
          ('class=Evince', ''),
          ('*', ''),
      ]
    '';
  };
in {
  module = {
    type = "custom/script";
    exec = "${python} ${module} ";
    tail = true;
  };
}
