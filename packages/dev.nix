pkgs:

let
  python-packages = python-packages: with python-packages; [
    pip
  ];

  python = pkgs.python3.withPackages python-packages;

  python2-packages = python-packages: with python-packages; [
    pip
  ];

  python2 = pkgs.python2.withPackages python2-packages;

  haskell-packages = haskellPackages: with haskellPackages; [
    tidal
    happy
    alex
    unordered-containers
  ];

  haskell = pkgs.ghc.withPackages haskell-packages;
in

with pkgs;

[
  git

  # C++
  gcc
  gdb
  cmake
  valgrind

  # Python
  python2
  python

  # Haskell
  haskell

  # Editors
  atom

  # Java
  openjdk11
]
