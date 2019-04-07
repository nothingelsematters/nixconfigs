{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.kitty
  ];
  xdg.configFile.kitty_config = {
    target = "kitty/kitty.conf";
    text = ''
      # WTF, really
      enable_audio_bell no

      # Font
      font_family  Fira Code
      font_size    16.0

      window_padding_width 8.0

      # Cursor
      cursor			 #d8dee9

      # Colors
      foreground		        #d8dee9
      background		        #2e3440
      selection_foreground	#2e3440
      selection_background	#d8dee9

      color0 			#3b4252
      color1 			#bf616a
      color2 			#a3be8c
      color3 			#ebcb8b
      color4 			#81a1c1
      color5 			#b48ead
      color6 			#88c0d0
      color7 			#e5e9f0
      color8 			#4c566a
      color9 			#bf616a
      color10 		#a3be8c
      color11 		#ebcb8b
      color12 		#81a1c1
      color13 		#b48ead
      color14 		#8fbcbb
      color15 		#eceff4

    '';
  };
}
