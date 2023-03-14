{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ rustup ];
    sessionVariables.PATH = "$PATH:/Users/simon/.cargo/bin";
  };

  programs = {
    zsh.shellAliases = {
      c = "cargo";
      "c.t" = "RUST_BACKTRACE=1 cargo test -- --nocapture";
      "c.t.r" = "RUST_BACKTRACE=1 cargo test --release -- --nocapture";
    };

    vscode = {
      userSettings = {
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.cargo.features" = "all";
        "rust-analyzer.cargo.extraArgs" = [ "--target-dir" "target/rls" ];
      };

      extensions = with pkgs.vscode-extensions; [
        matklad.rust-analyzer
        serayuzgur.crates
        tamasfe.even-better-toml
      ];
    };
  };
}
