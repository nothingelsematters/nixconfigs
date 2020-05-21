#!/usr/bin/env bash

NIXCONFIGS=/etc/nixos

set -o errexit
set -o nounset
set -o pipefail

function usage() {
cat << EOF
Usage:
  make.sh build
  make.sh switch
  make.sh update
  make.sh clean
  make.sh link
EOF
}

function trace() {
    echo -e "\e[1;34m> $*\e[0m" >&2
    "$@" || exit
}

function diff() {
    trace nix-shell -p python3 --run "$NIXCONFIGS/nix/diff.py /var/run/current-system '$drv'" >&2
}

function build() {
    export NIX_PATH=nixpkgs="$(nix eval --raw '(import nix/sources.nix).nixpkgs.outPath')"
    tmp=$(mktemp -u)
    trace nix build --no-link -f "$NIXCONFIGS/default.nix" -o "$tmp/result" --keep-going --show-trace $* >&2
    trap "rm -f '$tmp/result'" EXIT
    drv=$(readlink "$tmp/result")
    diff
    echo "$drv"
}

function switch() {
    drv=$(build)
    trace sudo nix-env -p /nix/var/nix/profiles/system --set "$drv"
    NIXOS_INSTALL_BOOTLOADER=1 trace sudo --preserve-env=NIXOS_INSTALL_BOOTLOADER "$drv/bin/switch-to-configuration" switch
}

function update() {
    ADDONS=$NIXCONFIGS/home/programs/firefox/addons
    trace nixpkgs-firefox-addons $ADDONS/addons.json $ADDONS/default.nix || true
    nixfmt $ADDONS/default.nix
    trace niv update
    build
}

function clean() {
    trace sudo nix-collect-garbage -d
    trace sudo nix optimise-store
}

function link() {
    ln -srf /etc/nixos .
}

cd "$( dirname "${BASH_SOURCE[0]}" )"

[[ $# -lt 1 ]] && usage && exit
mode="$1"
shift
eval $mode || usage
