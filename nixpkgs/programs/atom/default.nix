{
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
