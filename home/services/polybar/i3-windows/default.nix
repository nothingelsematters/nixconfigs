{ pkgs, lib, ... }:

let
  theme = (import ../../../theme { inherit pkgs lib; }).colors;
  i3w-folder = ".config/polybar/i3-windows";
  modulePath = i3w-folder + "/module.py";
  commandPath = i3w-folder + "/command.py";
  python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]);

  addVars = with builtins;
    file: vars:
    let
      lines = filter isString (split "\n" (readFile file));
      isPrefix = prefix: str:
        stringLength prefix <= stringLength str
        && substring 0 (stringLength prefix) str == prefix;
      snd = x: elemAt x 1;
      folder = x: y:
        if head x then [
          true
          (snd x ++ [ y ])
        ] else
          (if (y == "" || isPrefix "import " y || isPrefix "from " y) then [
            false
            (snd x ++ [ y ])
          ] else [
            true
            (snd x ++ [ vars y ])
          ]);
      patched = foldl' folder [ false [ ] ] lines;
    in concatStringsSep "\n" (snd patched);
in {
  home.file = {
    "${commandPath}".source = ./command.py;
    "${modulePath}".text = addVars ./module.py ''
      focused = '${theme.text.secondary}'
      wfocused = '${theme.text.primary}'
      unfocused = '${theme.text.disabled}'
      urgent = '${theme.text.urgent}'

      empty = ''
      ICON_FONT = 3
      COMMAND = 'python3 ${commandPath}'
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

  module = {
    type = "custom/script";
    exec = "${python}/bin/python3 ${modulePath}";
    tail = true;
  };
}
