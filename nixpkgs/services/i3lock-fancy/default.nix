{ config, pkgs, ... }:


let
  directory = ".config/i3lock-fancy/icons";
  sourceDirectory = ./icons;
  lockName = "circlelockclear.png";
  lockDarkName = "circlelockcleardark.png";
  lock = "${directory}/${lockName}";
  lockdark = "${directory}/${lockDarkName}";

  startScript = pkgs.writeShellScriptBin "i3lock-fancy.sh" ''
    set -o errexit -o noclobber -o nounset

    I3LOCK=${pkgs.i3lock}/bin/i3lock
    CONVERT=${pkgs.imagemagick}/bin/convert
    IMPORT=${pkgs.imagemagick}/bin/import
    AWK=${pkgs.gawk}/bin/gawk
    MKTEMP=${pkgs.coreutils}/bin/mktemp
    RM=${pkgs.coreutils}/bin/rm


    hue=(-level "0%,100%,0.6")
    text="Type password to unlock"
    font="Fira-Code-Medium"
    effect=(-filter Gaussian -resize 20% -define "filter:sigma=1.5" -resize 500.5%)
    # effect=(-scale 10% -scale 1000%)
    image=$($MKTEMP --suffix=.png)
    shot=($IMPORT -window root)
    i3lock_cmd=($I3LOCK -i "$image")

    # move pipefail down as for some reason "convert -list font" returns 1
    set -o pipefail
    trap '$RM -f "$image"' EXIT

    command -- "''${shot[@]}" "$image"

    value="60" #brightness value to compare to

    color=$($CONVERT "$image" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
        -resize 1x1 txt:- | $AWK -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

    if [[ $color -gt $value ]]; then #white background image and black text
        bw="black"
        icon="$HOME/.config/i3lock-fancy/icons/circlelockcleardark.png"
        param=("--insidecolor=0000001c" "--ringcolor=0000003e" \
            "--linecolor=00000000" "--keyhlcolor=ffffff80" "--ringvercolor=ffffff00" \
            "--separatorcolor=22222260" "--insidevercolor=ffffff1c" \
            "--ringwrongcolor=ffffff55" "--insidewrongcolor=ffffff1c" \
            "--verifcolor=ffffff00" "--wrongcolor=ff000000" "--timecolor=ffffff00" \
            "--datecolor=ffffff00" "--layoutcolor=ffffff00")
    else #black
        bw="white"
        icon="$HOME/.config/i3lock-fancy/icons/circlelockclear.png"
        param=("--insidecolor=ffffff1c" "--ringcolor=ffffff3e" \
            "--linecolor=ffffff00" "--keyhlcolor=00000080" "--ringvercolor=00000000" \
            "--separatorcolor=22222260" "--insidevercolor=0000001c" \
            "--ringwrongcolor=00000055" "--insidewrongcolor=0000001c" \
            "--verifcolor=00000000" "--wrongcolor=ff000000" "--timecolor=00000000" \
            "--datecolor=00000000" "--layoutcolor=00000000")
    fi

    $CONVERT "$image" "''${hue[@]}" "''${effect[@]}" -font "$font" -pointsize 26 -fill "$bw" -gravity center \
        -annotate +0+160 "$text" "$icon" -gravity center -composite "$image"

    # try to use i3lock with prepared parameters
    if ! "''${i3lock_cmd[@]}" "''${param[@]}" >/dev/null 2>&1; then
        # We have failed, lets get back to stock one
        "''${i3lock_cmd[@]}"
    fi
  '';
in
{
  home.packages = [ pkgs.imagemagick ];
  home.file."${lock}".source = "${sourceDirectory}/${lockName}";
  home.file."${lockdark}".source = "${sourceDirectory}/${lockDarkName}";

  services.screen-locker = {
    enable = true;
    inactiveInterval = 10;
    lockCmd = "${startScript}/bin/i3lock-fancy.sh -f Fira-Code-Medium";
  };
}
