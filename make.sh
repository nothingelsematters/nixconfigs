#!/usr/bin/env bash

NIXCONFIGS=/etc/nixos

set -o errexit
set -o nounset
set -o pipefail

function trace() {
    echo "> $@" >&2; "$@"
}

function trace2() {
    echo ">> $@" >&2; "$@"
}

function usage() {
cat << EOF
Usage:
  make.sh build
  make.sh switch
  make.sh update
  make.sh info
  make.sh cleanup
  make.sh link
  make.sh help
EOF
}

function invalid_syntax() {
    echo "Invalid syntax." 2>&1
    usage 2>&1
    return 1
}

function diff() {
    nix-shell -p python3 --run "$NIXCONFIGS/nix/diff.py /var/run/current-system '$drv' >&2"
}

cd "$( dirname "${BASH_SOURCE[0]}" )"

[[ $# -lt 1 ]] && invalid_syntax

mode="$1"
shift

case "$mode" in
    "build")
        trace2 nix-shell -p nixfmt fd --run "fd --full-path $NIXCONFIGS -e nix -E 'packages' -x nixfmt"
        tmp="$(mktemp -u)"
        trace2 nix build --no-link -f "$NIXCONFIGS/default.nix" system -o "$tmp/result" --keep-going $* >&2
        trap "rm '$tmp/result'" EXIT
        drv="$(readlink "$tmp/result")"
        diff
        echo "$drv"
        ;;
    "switch")
        drv="$(trace $NIXCONFIGS/make.sh build)"
        trace2 sudo nix-env -p /nix/var/nix/profiles/system --set "$drv"
        NIXOS_INSTALL_BOOTLOADER=1 trace sudo --preserve-env=NIXOS_INSTALL_BOOTLOADER "$drv/bin/switch-to-configuration" switch
        ;;
    "update")
        ADDONS=$NIXCONFIGS/home/programs/firefox/addons
        trace nixpkgs-firefox-addons $ADDONS/addons.json $ADDONS/default.nix || true
        nixfmt $ADDONS/default.nix
        trace niv update
        drv="$(trace $NIXCONFIGS/make.sh build)"
        diff
        ;;
    "info")
        drv="$(trace $NIXCONFIGS/make.sh build)"

        trace2 echo "Derivation:"
        echo "$drv"
        echo

        trace2 echo "Biggest dependencies:"
        du -shc $(nix-store -qR "$drv") | sort -hr | head -n 21 || true
        echo

        trace2 echo "Auto GC roots:"
        roots=""
        for i in /nix/var/nix/gcroots/auto/*; do
          p="$(readlink "$i")"
          if [[ -e "$p" ]]; then
            s="$(du -sch $(nix-store -qR "$p") | tail -n 1 | grep -Po "^[^\t]*")"
            roots="$roots$s $p\n"
          fi
        done
        if [[ -n "$roots" ]];
        then echo -e "$roots" | sort -hr
        else echo "None."
        fi
        ;;
    "cleanup")
        trace sudo nix-collect-garbage --delete-older-than 7d
        trace sudo nix optimise-store
        ;;
    "link")
        ln -srf /etс/nixos .
        ;;
    "help")
        [[ $# -gt 0 ]] && invalid_syntax
        usage
        ;;
    *)
        invalid_syntax
esac
