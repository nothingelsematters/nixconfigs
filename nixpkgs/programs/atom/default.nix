{
  home.file.".atom/config.cson".text =
    ''
    "*":
      "autocomplete-clang":
        clangCommand: "clang++"
        "preCompiledHeaders c++": [
          "cassert"
          "cerrno"
          "cmath"
          "cstddef"
          "cstdio"
          "cstdlib"
          "cstring"
          "ctime"
          "deque"
          "list"
          "map"
          "queue"
          "set"
          "stack"
          "vector"
          "fstream"
          "iomanip"
          "ios"
          "iostream"
          "istream"
          "ostream"
          "sstream"
          "algorithm"
          "bitset"
          "complex"
          "exception"
          "functional"
          "iterator"
          "limits"
          "memory"
          "new"
          "numeric"
          "stdexcept"
          "string"
          "typeinfo"
          "utility"
        ]
        "std c++": "c++17"
      core:
        autoHideMenuBar: true
        disabledPackages: [
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
          "language-coffee-script"
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
          "wrap-guide"
          "spell-check"
          "timecop"
          "dev-live-reload"
          "autocomplete-haskell"
          "haskell-ghc-mod"
          "atom-latex"
          "docblockr"
          "ide-java"
          "language-tex"
        ]
        reopenProjectMenuCount: 8
        restorePreviousWindowsOnStart: "no"
        telemetryConsent: "no"
        themes: [
          "material-ui"
          "material-monokai-syntax"
        ]
      editor:
        fontFamily: "Hasklig Medium"
        fontSize: 10
        showIndentGuide: true
        tabLength: 4
      "markdown-preview-enhanced":
        previewTheme: "github-dark.css"
      minimap:
        plugins:
          cursorline: true
          cursorlineDecorationsZIndex: 0
          "git-diff": true
          "git-diffDecorationsZIndex": 0
          selection: true
          selectionDecorationsZIndex: 0
          "split-diff": true
          "split-diffDecorationsZIndex": 0
      welcome:
        showOnStartup: false
    ".nix":
      editor:
        tabLength: 2
    '';

  home.file.".atom/snippets.cson".text =
    ''
    ".source.cpp":
      "for size_t":
        "prefix": "fors"
        "body": """
          for (size_t $\{1:i} = $\{2:0}; $\{1:i} < $\{3:size}; ++$\{1:i}) {
              $\{4:/*body*/}
          }
        """
      "for auto":
        "prefix": "fora"
        "body": """
          for (auto$\{2:} $\{1:name} : $\{3:container}) {
              $\{4:/*body*/}
          }
        """
      "include iostream":
        "prefix": "ios"
        "body": "#include <iostream>"
      "include fstream":
        "prefix": "fst"
        "body": "#include <fstream>"
      "simple main":
        "prefix": "mains"
        "body": """
          int main() {
              $\{1:/*code*/}

              return 0;
          }
        """

    '';
}
