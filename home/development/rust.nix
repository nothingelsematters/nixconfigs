{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ rustup ];
    sessionPath = [ "$HOME/.cargo/bin" ];
  };

  programs = {
    zsh.shellAliases = {
      c = "cargo";
      "c.c" = "cargo clippy --fix --allow-dirty --allow-staged";
      "c.t" = "RUST_BACKTRACE=1 cargo test -- --nocapture";
      "c.t.r" = "RUST_BACKTRACE=1 cargo test --release -- --nocapture";
    };

    vscode.profiles.default = {
      userSettings = {
        "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.cargo.features" = "all";
      };

      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        serayuzgur.crates
        tamasfe.even-better-toml
      ];
    };
  };
}
