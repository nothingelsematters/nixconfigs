{ pkgs, ... }:

{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        indent_size = 4;
        indent_style = "space";
        end_of_line = "lf";
        max_line_length = 120;
        insert_final_newline = true;
        trim_trailing_whitespace = true;
      };

      "*.{json, html, css}".indent_size = 2;
      "*.md".trim_trailing_whitespace = false;
    };
  };

  programs.vscode.profiles.default.extensions = [ pkgs.vscode-extensions.editorconfig.editorconfig ];
}
