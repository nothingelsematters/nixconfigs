self:
super:

let
  version = "3.4.0";
in
{
  guake-fixed = super.python3.pkgs.buildPythonApplication rec {
    name = "guake-fixed-${version}";
    format = "other";

    src = super.fetchFromGitHub {
      owner = "Guake";
      repo = "guake";
      rev = version;
      sha256 = "1j38z968ha8ij6wrgbwvr8ad930nvhybm9g7pf4s4zv6d3vln0vm";
    };

    nativeBuildInputs = with self; [ gettext gobject-introspection wrapGAppsHook python3.pkgs.pip glibcLocales ];

    buildInputs = with self; [ gobject-introspection gtk3 keybinder3 libnotify python3 vte gnome3.vte ];

    propagatedBuildInputs = with self.python3.pkgs; [ dbus-python pbr pycairo pygobject3 ];

    LC_ALL = "en_US.UTF-8";

    PBR_VERSION = version; # pbr needs either .git directory, sdist, or env var

    strictDeps = false;

    postPatch = ''
      # unnecessary /usr/bin/env in Makefile
      # https://github.com/Guake/guake/pull/1285
      substituteInPlace "Makefile" --replace "/usr/bin/env python3" "python3"
    '';

    makeFlags = [
      "prefix=$(out)"
    ];

    preFixup = ''
      gappsWrapperArgs+=(--prefix LD_LIBRARY_PATH : "${super.stdenv.lib.makeLibraryPath [ self.libutempter ]}")
    '';
  };
}
