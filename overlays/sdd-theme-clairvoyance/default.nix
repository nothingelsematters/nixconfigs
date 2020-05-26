self: super:

let
  sources = import ../../nix/sources.nix;
  clairvoyance = sources.sddm-theme-clairvoyance;
in {
  sddm-theme-clairvoyance = super.stdenv.mkDerivation {
    pname = "sddm-theme-clairvoyance";
    version = clairvoyance.rev;
    src = clairvoyance;

    nativeBuildInputs = with self; [ imagemagick ];

    installPhase = ''
      theme=$out/share/clairvoyance
      mkdir -p $theme
      tmp=$out/tmp
      mkdir -p $out/tmp
      cp -r * $theme
      cp ${./theme.conf} $theme/theme.conf

      tl="850,400"
      br="1070,620"

      # Get x1,y1,x2,y2 - bounding box of inserted image
      IFS=, read -r x1 y1 <<< "$tl"
      IFS=, read -r x2 y2 <<< "$br"

      # Work out w and h, and smaller side "s"
      w=$((x2-x1+1))
      h=$((y2-y1+1))
      s=$w
      [ $h -lt $w ] && s=$h

      convert ${./logo.png} -alpha on \
              \( +clone -threshold -1 -negate -fill white -draw "circle 130,130 130,0" \) \
              -alpha off -compose copy_opacity -resize ''${s}x''${s}  -composite $tmp/tmp.png
      convert $theme/Assets/Background.jpg \
          \( $tmp/tmp.png -background none -extent ''${w}x''${h} \) \
          -gravity northwest -geometry +''${x1}+''${y1} -composite $theme/Assets/Background.png

      rm -rf $tmp
    '';

    meta.description = "sddm greeter clairvoyance theme";
  };
}
