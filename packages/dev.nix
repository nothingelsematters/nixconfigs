pkgs:

let
  python-packages = python-packages: with python-packages; [
    virtualenv
    pip
    tkinter
    python-language-server
  ];

  python = pkgs.python3.withPackages python-packages;

  python2-packages = python-packages: with python-packages; [
    virtualenv
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

  # Editor
  atom

  # Java
  openjdk11
]
