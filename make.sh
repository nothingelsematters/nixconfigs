#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

QUIET=false
NODIFF=false
RETURN=""

declare -a usage=("build" "switch" "update" "clean" "link" "vm" "help")

function help() {
    echo "Usage:"
    for i in ${usage[@]}; do
        echo "  make.sh" $i
    done
}

function info() {
    echo -e "\e[1;34m> $*\e[0m" >&2
}

function trace() {
    if ! $QUIET
    then
        info $*
    fi
    "$@"
}

function _build() {
    tmp=$(mktemp -u)
    nixpkgs_path="$(nix eval --raw "(import ${NIXCONFIGS}/nix/sources.nix).nixpkgs.outPath")"
    export NIX_PATH=nixpkgs="${nixpkgs_path}"
    trace nix build --no-link -f "$NIXCONFIGS/$buildfile" -o "$tmp/result" --keep-going --show-trace "$@" >&2
    trap "rm -f '$tmp/result'" EXIT
    drv=$(readlink "$tmp/result")
    info built "$drv"

    if ! $QUIET && ! $NODIFF
    then
        trace generation-diff /var/run/current-system "$drv" >&2
    fi
    RETURN="$drv"
}

function build() {
    buildfile=default.nix
    _build
}

function vm() {
    NODIFF=true
    buildfile=vm.nix
    _build
}

function switch() {
    build
    drv=$RETURN
    trace sudo nix-env -p /nix/var/nix/profiles/system --set "$drv"
    NIXOS_INSTALL_BOOTLOADER=1 trace sudo --preserve-env=NIXOS_INSTALL_BOOTLOADER "$drv/bin/switch-to-configuration" switch
}

function update() {
    # ADDONS=$NIXCONFIGS/home/programs/browser/firefox/addons
    # trace nixpkgs-firefox-addons $ADDONS/addons.json $ADDONS/default.nix || true
    # nixfmt $ADDONS/default.nix
    cd $NIXCONFIGS
    trace niv update
    build
}

function clean() {
    trace sudo nix-collect-garbage -d
    trace sudo nix optimise-store
}

NIXCONFIGS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"

[[ $# -lt 1 ]] && help && exit
mode="$1"
shift

while ! [ -z ${1+x} ]
do
    case "$1" in
        "--")
            shift
            break
            ;;
        "-Q" | "--quiet")
            echo "Building quietly"
            QUIET=true
            ;;
        "--no-diff")
            NODIFF=true
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
    shift
done

if [[ ${usage[*]} =~ $mode ]]
then $mode $*
else help
fi
