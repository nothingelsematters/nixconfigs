pkgs:
let
    speechd-pulse = pkgs.speechd.override {
    	withPulse = true;
    };
in
  with pkgs;
  [

    # Archive management
    atool
    unrar
    unzip
    bzip2
    zip

    # Image editing
    # imagemagick
    # pinta
    # krita
    # gimp

    # Messaging
    tdesktop

    # Media
    # ffmpegthumbnailer   # For ranger previews
    google-play-music-desktop-player
    lollypop
    mpv
    pulseeffects
    # sox
    # w3m    # For ranger previews
    # xpdf   # For ranger previews

    # Browsing
    firefox

    # Unsorted yet. Fuck it.
    tldr
    unclutter
    # pv
    # gparted
    # zathura
    # highlight
    htop
    # alacritty
    psmisc
    playerctl
    # supercollider
    # jack2Full
    networkmanagerapplet
    blueman
    file
    nox
    libreoffice-unwrapped
    # texlive.combined.scheme-full
    hunspell
    hunspellDicts.en-us
    gnumake
    binutils
    shared-mime-info
    lf
    inotify-tools
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
    aspellDicts.ru
    gnutls
    ffmpeg
    jmtpfs
    arandr
    pavucontrol
    telnet
    speechd-pulse
    gnupg

    # Fixes "failed to commit changes to dconf" issues
    gnome3.dconf

    # Utility packages
    autojump
    most
    fd
    ripgrep
    exa
    bat
    fzf
    wget

    libinput-gestures

    arc-theme
  ]
