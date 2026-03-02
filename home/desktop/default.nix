# home/desktop/gnome.nix
{ pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    yaru-theme
    ubuntu-themes
  ];

  dconf.settings = {

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
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
      dock-position = "LEFT";
      dock-fixed = true;
      dash-max-icon-size = 48;
      extend-height = true;
      #apply-custom-theme = true;
      custom-theme-shrink = true;
      running-indicator-style = "DOTS";
      show-trash = true;
      hot-keys = false; # Disables all dock hotkeys including Super+q
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      new-window = [ ]; # Disable the new-window keybinding
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      toggle-maximized = [ "<Super>m" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-applications = [ ];
      switch-applications-backward = [ ];
      minimize = [ "<Super>h" ];
      maximize = [ ];
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

      accent-color = "blue";
      clock-show-seconds = true;
      clock-show-weekday = true;
      enable-hot-corners = false;
    };

    # Window title font
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Ubuntu Nerd Font Bold 13";

      button-layout = "appmenu:minimize,maximize,close";
    };

    # Power management settings to prevent automatic suspend
    "org/gnome/settings-daemon/plugins/power" = {
      # Disable automatic suspend on AC power
      sleep-inactive-ac-timeout = 0;
      sleep-inactive-ac-type = "nothing";
      power-button-action = "nothing";
    };

    # Nautilus
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      show-hidden-files = false;
    };

    "org/gnome/nautilus/list-view" = {
      default-visible-columns = [
        "name"
        "size"
        "type"
        "date_modified"
      ];
      default-zoom-level = "small"; # "small", "medium", "large"
      use-tree-view = true;
    };
  };

  # PaperWM copies metadata.json and user.css from the Nix store with read-only
  # permissions (444). This activation script ensures they are writable so
  # PaperWM can update them at runtime.
  home.activation.paperwmWritable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/.config/paperwm" ]; then
      chmod -f u+w "$HOME/.config/paperwm/metadata.json" "$HOME/.config/paperwm/user.css" || true
    fi
  '';

  # GTK font settings
  gtk = {
    enable = true;

    theme = {
      name = "Yaru-dark";
      package = pkgs.yaru-theme;
    };

    iconTheme = {
      name = "Yaru-dark";
      package = pkgs.yaru-theme;
    };

    cursorTheme = {
      name = "Yaru";
      size = 24;
    };

    font = {
      name = "Ubuntu Nerd Font";
      size = 11;
    };
  };
}
