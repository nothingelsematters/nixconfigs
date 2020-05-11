{ pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs lib; };
  toCSON = import ../../lib/toCSON.nix { inherit pkgs; };

  config = {
    "*" = {
      core = {
        autoHideMenuBar = true;
        disabledPackages = [
          "language-gfm"
          "about"
          "autocomplete-atom-api"
          "autocomplete-css"
          "autocomplete-html"
          "autoflow"
          "autosave"
          "background-tips"
          "bookmarks"
          "command-palette"
          "dalek"
          "deprecation-cop"
          "exception-reporting"
          "image-view"
          "incompatible-packages"
          "keybinding-resolver"
          "language-clojure"
          "language-csharp"
          "language-go"
          "language-html"
          "language-hyperlink"
          "language-javascript"
          "language-less"
          "language-mustache"
          "language-objective-c"
          "language-perl"
          "language-php"
          "language-property-list"
          "language-ruby"
          "language-ruby-on-rails"
          "language-rust-bundled"
          "language-sass"
          "language-sql"
          "language-toml"
          "language-typescript"
          "language-xml"
          "language-yaml"
          "link"
          "markdown-preview"
          "metrics"
          "package-generator"
          "open-on-github"
          "styleguide"
          "welcome"
          "spell-check"
          "timecop"
          "dev-live-reload"
          "autocomplete-haskell"
          "haskell-ghc-mod"
          "atom-latex"
          "docblockr"
          "ide-java"
        ];

        reopenProjectMenuCount = 8;
        restorePreviousWindowsOnStart = "no";
        telemetryConsent = "no";

        themes = [ "atom-material-ui" "material-monokai-syntax" ];
      };

      editor = {
        fontFamily = theme.fonts.mono.name;
        fontSize = 10;
        preferredLineLength = 80;
        showIndentGuide = true;
        softWrap = true;
        softWrapHangingIndent = 4;
        tabLength = 4;
      };

      "markdown-preview-enhanced".previewTheme = "github-dark.css";

      minimap.plugins = {
        cursorline = true;
        cursorlineDecorationsZIndex = 0;
        "git-diff" = true;
        "git-diffDecorationsZIndex" = 0;
        selection = true;
        selectionDecorationsZIndex = 0;
        "split-diff" = true;
        "split-diffDecorationsZIndex" = 0;
      };
      welcome.showOnStartup = false;
      "wrap-guide".enabled = false;
      "tree-view".squashDirectoryNames = true;
    };

    ".coffee.source".editor.tabLength = 2;

    ".haskell.source" = {
      editor.tabLength = 2;
      "wrap-guide".enabled = true;
    };

    ".nix.source".editor.tabLength = 2;

    "atom-beautify".haskell.default_beautifier = "stylish-haskell";
  };
in toCSON config
