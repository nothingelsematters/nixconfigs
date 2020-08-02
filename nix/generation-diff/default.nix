self: super:

{
  generation-diff = super.stdenv.mkDerivation {
    pname = "generation-diff";
    version = "0.0.2";
    src = ./.;

    buildInputs = with self; [ bash jq nix ];
    nativeBuildInputs = with self; [ kotlin makeWrapper ];

    buildPhase = ''
      mkdir -p $out/share/java
      ${self.kotlin}/bin/kotlinc GenerationDiff.kt -include-runtime -d $out/share/java/diff.jar
    '';

    installPhase = ''
      mkdir -p $out/bin
      makeWrapper ${self.kotlin}/bin/kotlin $out/bin/generation-diff \
        --add-flags "-cp $out/share/java/diff.jar GenerationDiffKt"
    '';

    meta.description = "nix build diff tool";
  };
}
