{ pkgs, ... }:

{
  # home.packages = [ pkgs.prev-stable.flutter ];
  programs.vscode.extensions = [ pkgs.vscode-extensions.dart-code.flutter ];
}
