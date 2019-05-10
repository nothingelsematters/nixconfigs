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

  # Editors
  atom

  # C++
  llvmPackages.clang-unwrapped
  (lowPrio gcc)
  gdb
  cmake
  valgrind

  # Java
  openjdk11

  # Haskell
  haskell

  # Python
  python2
  python
]
