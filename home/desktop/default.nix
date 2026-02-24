# home/desktop/gnome.nix
{ pkgs, lib, ... }:

{
  dconf.settings = {

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "Vitals@CoreCoding.com"
        "paperwm@paperwm.github.com"
        # "just-perfection-desktop@just-perfection"
      ];
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "Alacritty.desktop"
      ];
    };

    # Set Alacritty as default terminal
    "org/gnome/desktop/applications/terminal" = {
      exec = "alacritty";
      exec-arg = "-e";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 225; # 15 * 15ms = 225ms (matches macOS InitialKeyRepeat 15)
      repeat-interval = lib.hm.gvariant.mkUint32 15; # 1 * 15ms = 15ms (matches macOS KeyRepeat 1)
    };

    # PaperWM specific settings
    "org/gnome/shell/extensions/paperwm" = {
      # Window gaps
      window-gap = 8;

      # Disable top bar styling if you prefer stock GNOME
      override-panel-styling = false;

      # Animation time in ms
      animation-time = 0.15;

      # Gesture options
      gesture-enabled = true;

      # Show window position bar
      show-window-position-bar = true;
    };

    # Disable the dock's Super+q keybinding
    "org/gnome/shell/extensions/dash-to-dock" = {
      hot-keys = false; # Disables all dock hotkeys including Super+q
      extend-height = false;
      dock-fixed = true; # Don't reserve space permanently
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      new-window = [ ]; # Disable the new-window keybinding
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>m" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      terminal = [ "<Super>Return" ];
    };

    # Interface fonts
    "org/gnome/desktop/interface" = {
      # Main UI font
      font-name = "Ubuntu Nerd Font 11";

      # Document viewer font
      document-font-name = "Ubuntu Nerd Font 11";

      # Terminal and code font
      monospace-font-name = "UbuntuMono Nerd Font Mono 11";

      # Font rendering options
      font-antialiasing = "rgba"; # Smooth fonts
      font-hinting = "slight"; # Slight hinting
      font-rgba-order = "rgb"; # Subpixel order

      clock-show-seconds = true;
      clock-show-weekday = true;
    };

    # Window title font
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Nerd Font Bold 13";
    };

  };

  # GTK font settings
  gtk = {
    enable = true;

    font = {
      name = "Ubuntu Nerd Font";
      size = 11;
    };
  };
}
