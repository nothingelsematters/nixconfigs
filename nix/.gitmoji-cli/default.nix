self: super:

let src = super.gitmoji-cli;
in {
  gitmoji-cli = super.stdenv.mkDerivation {
    pname = "gitmoji-cli";
    version = src.rev;
    inherit src;

    nativeBuildInputs = with self; [ imagemagick ];

    # TODO
    installPhase = ''
      ${super.node2nix} .
      ${super.nix} import
    '';

    meta.description = "sddm greeter clairvoyance theme";
  };
}
