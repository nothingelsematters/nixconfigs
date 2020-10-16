{ buildFirefoxXpiAddon, stdenv }: {
  "adblocker-ultimate" = buildFirefoxXpiAddon {
    pname = "adblocker-ultimate";
    version = "2.43";
    addonId = "adblockultimate@adblockultimate.net";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3482195/adblocker_ultimate-2.43-an+fx.xpi?src=";
    sha256 = "60c19f5c18af77e12bc70b47dcccf61e48173329349b6b8da24b44f685880bc7";
    meta = with stdenv.lib; {
      homepage = "https://adblockultimate.net";
      description =
        "Completely remove ALL ads. No “acceptable” ads or whitelisted advertisers allowed. This free extensions also helps block trackers and malware.";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  };
  "duckduckgo-for-firefox" = buildFirefoxXpiAddon {
    pname = "duckduckgo-for-firefox";
    version = "2019.12.12";
    addonId = "jid1-ZAdIEUB7XOzOJw@jetpack";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3467553/duckduckgo_privacy_essentials-2019.12.12-an+fx.xpi?src=";
    sha256 = "3c61235d9075c8e4b8de35f848df88293a241182fbc18b6a6710c018e25492e5";
    meta = with stdenv.lib; {
      homepage = "https://duckduckgo.com/app";
      description =
        "Privacy, simplified. Our add-on provides the privacy essentials you need to seamlessly take control of your personal information, no matter where the internet takes you: tracker blocking, smarter encryption, DuckDuckGo private search, and more.";
      platforms = platforms.all;
    };
  };
  "enhancer-for-youtube" = buildFirefoxXpiAddon {
    pname = "enhancer-for-youtube";
    version = "2.0.99";
    addonId = "enhancerforyoutube@maximerf.addons.mozilla.org";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3467325/enhancer_for_youtubetm-2.0.99-fx.xpi?src=";
    sha256 = "896b1705414c0de562465b18917e5555e3300e6a86863959770f0b5b7252a11a";
    meta = with stdenv.lib; {
      homepage = "https://www.mrfdev.com/enhancer-for-youtube";
      description =
        "Tons of features to improve your user experience on YouTube™.";
      platforms = platforms.all;
    };
  };
  "github-dark-theme" = buildFirefoxXpiAddon {
    pname = "github-dark-theme";
    version = "1.0.44";
    addonId = "{1dbe3fd3-f191-4a3b-a5d7-a6f95ed2aea1}";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/3520947/github_dark_theme-1.0.44-an+fx.xpi?src=";
    sha256 = "61f432d5e2eb25b4c66de09e99c31ae5d6cf17fa70cd13a56f808af0394c91e8";
    meta = with stdenv.lib; {
      homepage =
        "https://poychang.github.io/github-dark-theme/?utm_source=firefoxaddon";
      description = ''
        A dark theme for all of GitHub based on Atom One Dark.
        Source Code: <a href="https://outgoing.prod.mozaws.net/v1/1e5d67005f76e756fb730891b2db930783c3cf919ff91c7aabdafa0be3ed15d1/https%3A//github.com/poychang/github-dark-theme" rel="nofollow">https://github.com/poychang/github-dark-theme</a>'';
      license = licenses.mit;
      platforms = platforms.all;
    };
  };
  "github-file-icon" = buildFirefoxXpiAddon {
    pname = "github-file-icon";
    version = "0.8.1";
    addonId = "{85860b32-02a8-431a-b2b1-40fbd64c9c69}";
    url =
      "https://addons.mozilla.org/firefox/downloads/file/1657568/file_icon_for_github_gitlab_and_bitbucket-0.8.1-fx.xpi?src=";
    sha256 = "03de541774c4e691880a9e086a1fa215eca2c07c1ef2bbb4445f34f9f1439f2f";
    meta = with stdenv.lib; {
      homepage = "https://github.com/xxhomey19/github-file-icon";
      description =
        "A Firefox Add-On which gives different filetypes different icons to GitHub, Gitlab, Bitbucket, gitea and gogs.";
      license = licenses.mit;
      platforms = platforms.all;
    };
  };
}
