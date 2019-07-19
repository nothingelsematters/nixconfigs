let
  theme = import ./nord.nix;
  colors = theme.colors;
  opaque = theme.opaque;
in rec {
  inherit colors opaque;

  toCss = ''
            :root {
                --theme-primary:  ${colors.primary};
                --theme-accent:   ${colors.accent};
                --theme-disabled: ${colors.disabled};
                --theme-text:     ${colors.text};
                --theme-active:   ${colors.active};
                --theme-strong:   ${colors.strong};
            }
          '';
}
