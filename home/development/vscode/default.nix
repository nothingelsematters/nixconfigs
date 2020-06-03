{ config, pkgs, lib, ... }:

with config.lib;
let
  allHies = fetchTarball "https://github.com/infinisil/all-hies/tarball/master";
  selection = { selector = p: { inherit (p) ghc882; }; };
  hie = (import allHies { }).unstable.selection selection;
in {
  lib.packages.editor = {
    name = "code";
    package = pkgs.vscode;
  };

  programs.vscode = {
    enable = true;

    haskell = {
      enable = true;
      hie = {
        enable = true;
        executablePath = hie + /bin/hie;
      };
    };

    extensions = with pkgs;
      [ vscode-extensions.bbenoist.Nix ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "bracket-pair-colorizer-2";
          publisher = "coenraads";
          version = "0.1.2";
          sha256 = "1n34m3i5cjd0x2qcvvk5ipp5ippxmsrq6218xw40ag0n39lsknri";
        }
        {
          name = "file-icons";
          publisher = "file-icons";
          version = "1.0.24";
          sha256 = "0mcaz4lv7zb0gw0i9zbd0cmxc41dnw344ggwj1wy9y40d627wdcx";
        }
        {
          name = "todo-tree";
          publisher = "gruntfuggly";
          version = "0.0.174";
          sha256 = "0636sjcdhpiwmqrj13py97j0svn7pq5c9kjmarrjv7ivzk8q8f9k";
        }
        {
          name = "vscode-diff";
          publisher = "fabiospampinato";
          version = "1.4.0";
          sha256 = "10ayc6677clpnid4lm6h22v5635k1aidp7pr2iwkiblbqq6ri5s0";
        }
        {
          name = "git-graph";
          publisher = "mhutchie";
          version = "1.22.0";
          sha256 = "06j49pxz9vp6z4hax60jsn4fa2iig76d8p9cjhdhbvmyil0dgggx";
        }
        {
          name = "vsc-community-material-theme";
          publisher = "equinusocio";
          version = "1.4.1";
          sha256 = "0841aaf58c69x1r33xnflrh6kdw8xxhbbavfwsbl8lbn48r70wsb";
        }

        # haskell
        {
          name = "haskell-linter";
          publisher = "hoovercj";
          version = "0.0.6";
          sha256 = "0fb71cbjx1pyrjhi5ak29wj23b874b5hqjbh68njs61vkr3jlf1j";
        }
        {
          name = "stylish-haskell";
          publisher = "vigoo";
          version = "0.0.10";
          sha256 = "1zkvcan7zmgkg3cbzw6qfrs3772i0dwhnywx1cgwhy39g1l62r0q";
        }
        {
          name = "vscode-ghc-simple";
          publisher = "dramforever";
          version = "0.1.22";
          sha256 = "0x3csdn3pz5rhl9mhplpm8kxb40l1dw5rnwhh3zsif3rz0nqhk2a";
        }

        # nix
        {
          name = "nixfmt-vscode";
          publisher = "brettm12345";
          version = "0.0.1";
          sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
        }

        # kotlin
        {
          name = "kotlin";
          publisher = "fwcd";
          version = "0.2.11";
          sha256 = "1zk5qdppcgsal9fppmpyxn58fbpan405pvv70c5cj6kqwp5crw4s";
        }
        {
          name = "kotlin-formatter";
          publisher = "esafirm";
          version = "0.0.6";
          sha256 = "00w7d0iyr3nf5jqzwy7kk7awyh3fnljzrjbkknxmpjyjyvaa7n0z";
        }
      ];

    userSettings = {
      "breadcrumbs.enabled" = true;

      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = false;
      "editor.cursorStyle" = "underline";
      "editor.fontFamily" = "'${theme.fonts.mono.name}'";
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = false;
      "editor.minimap.maxColumn" = 200;
      "editor.minimap.renderCharacters" = false;
      "editor.minimap.showSlider" = "always";
      "editor.minimap.size" = "fit";
      "editor.renderWhitespace" = "none";
      "editor.formatOnSave" = true;
      "editor.rulers" = [ 80 ];
      "editor.smoothScrolling" = true;
      "editor.find.autoFindInSelection" = "always";
      "editor.fontSize" = 10;
      "editor.scrollBeyondLastLine" = false;
      "editor.multiCursorModifier" = "ctrlCmd";

      "explorer.autoReveal" = true;
      "explorer.openEditors.visible" = 0;

      "extensions.ignoreRecommendations" = true;
      "extensions.showRecommendationsOnlyOnDemand" = true;

      "files.autoSave" = "onFocusChange";
      "files.exclude"."**/.git" = true;
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;
      "files.watcherExclude" = {
        "**/.git/objects/**" = true;
        "**/.git/subtree-cache/**" = true;
        "**/node_modules/**" = true;
      };

      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;

      "terminal.integrated.cursorBlinking" = false;
      "terminal.integrated.cursorStyle" = "underline";
      "terminal.integrated.fontFamily" = theme.fonts.mono.name;
      "terminal.integrated.fontSize" = 10;
      "terminal.explorerKind" = "external";
      "terminal.external.linuxExec" = "kitty";

      "update.mode" = "none";

      "window.menuBarVisibility" = "toggle";
      "window.title" =
        "\${dirty} \${activeEditorMedium}\${separator}\${rootName}";
      "window.titleBarStyle" = "native";

      "workbench.colorTheme" = "Material Theme Palenight High Contrast";
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.iconTheme" = "file-icons";
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "workbench.startupEditor" = "none";
      "workbench.activityBar.visible" = true;
      "workbench.statusBar.visible" = true;
      "workbench.tips.enabled" = false;
      "workbench.tree.indent" = 18;

      "zenMode.centerLayout" = false;
      "zenMode.fullScreen" = false;
      "zenMode.hideLineNumbers" = false;
      "zenMode.hideStatusBar" = false;

      "files.maxMemoryForLargeFilesMB" = 1024;

      "todo-tree.tree.showScanModeButton" = false;

      # haskell
      "languageServerHaskell.hlintOn" = true;
      "languageServerHaskell.maxNumberOfProblems" = 100;
      "languageServerHaskell.formattingProvider" = "none";
      "[haskell]" = {
        "editor.defaultFormatter" = "vigoo.stylish-haskell";
        "editor.tabSize" = 2;
      };
      "haskell.hlint.executablePath" = pkgs.hlint + /bin/hlint;
      "haskell.hlint.run" = "onType";
      "ghcSimple.startupCommands.all" = [
        "System.IO.hSetBuffering System.IO.stderr System.IO.NoBuffering"
        "System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering"
        ":set -haddock"
      ];
      "stylishHaskell.commandLine" =
        "${pkgs.stylish-haskell}/bin/stylish-haskell"
        + " -c $HOME/university/functional-programming"
        + "/functional-programming-course/.stylish-haskell.yaml";

      # nix
      "[nix]" = {
        "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
        "editor.tabSize" = 2;
      };
      "nixfmt.path" = pkgs.nixfmt + /bin/nixfmt;
    };
  };
}
