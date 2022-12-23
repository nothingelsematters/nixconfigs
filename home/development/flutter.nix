{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      # TODO https://github.com/NixOS/nixpkgs/pull/196133
      # for now: https://docs.flutter.dev/get-started/install/macos
      # flutter
      cocoapods
    ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    dart-code.dart-code
    dart-code.flutter
  ];
}
