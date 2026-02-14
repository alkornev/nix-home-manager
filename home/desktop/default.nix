# home/desktop/gnome.nix
{ pkgs, ... }:

{
  dconf.settings = {

    # Interface fonts
    "org/gnome/desktop/interface" = {
      # Main UI font
      font-name = "Ubuntu 13";

      # Document viewer font
      document-font-name = "Ubuntu 13";

      # Terminal and code font
      monospace-font-name = "Ubuntu Mono 13";

      # Font rendering options
      font-antialiasing = "rgba";     # Smooth fonts
      font-hinting = "slight";        # Slight hinting
      font-rgba-order = "rgb";        # Subpixel order
    };

    # Window title font
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Bold 13";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = false;
      speed = 0.0;
      accel-profile = "default";
    };
  };

  # GTK font settings
  gtk = {
    enable = true;

    font = {
      name = "Ubuntu";
      size = 13;
    };
  };
}

