{ pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;

    config = {
      terminal = "alacritty";
      menu = "wofi --show drun";

      modifier = "Mod4"; # Super/Windows key

      bars = [];

      # Keybindings
      keybindings = let
        modifier = "Mod4";
      in lib.mkOptionDefault {
        # Screen lock
        "${modifier}+l" = "exec swaylock -f -c 000000";

        # Screenshot
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        "${modifier}+Print" = "exec grim - | wl-copy";

        # Brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

        # Volume controls
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      # Startup programs
      startup = [
        { command = "waybar"; }
        { command = "mako"; } # notification daemon
        { command = "blueman-applet"; } # Bluetooth applet
        { command = "nm-applet --indicator"; } # Network Manager applet
      ];


      # Input configuration
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_options = "ctrl:nocaps"; # Make Caps Lock another Ctrl
        };

        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };

      # Window rules
      window = {
        border = 2;
        titlebar = true;
      };

      gaps = {
        inner = 5;
        outer = 5;
      };

      # Focus follows mouse
      focus.followMouse = true;
    };

    extraConfig = ''
      # Additional sway configuration
      default_border pixel 2
      default_floating_border pixel 2

      # Disable mouse warping
      mouse_warping none

      # Set cursor theme
      seat seat0 xcursor_theme Bibata-Modern-Classic 24
    '';
  };

  # Waybar
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;

        modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
        modules-center = [ ];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "bluetooth"
          "cpu"
          "memory"
          "temperature"
          "clock"
          "tray"
        ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}";
        };

        "sway/mode" = {
          format = "<span style=\"italic\"> {}</span>";
        };

        "sway/window" = {
          format = "{}";
          max-length = 50;
          icon = true;
          icon-size = 16;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip-format-activated = "Idle inhibitor: {status}";
          tooltip-format-deactivated = "Idle inhibitor: {status}";
        };

        "clock" = {
          format = "{:%Y-%m-%d %H:%M:%S}";
          interval = 1;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "cpu" = {
          format = "󰻠 {usage}%";
          tooltip = false;
          interval = 2;
        };

        "memory" = {
          format = "󰍛 {percentage}%";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
        };

        "temperature" = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = ["󰜗" "󱃂" "󰔏" "󱃂" "󰸁"];
        };

        "network" = {
          format-wifi = "󰖩 {signalStrength}%";
          format-ethernet = "󰈀 {ifname}";
          format-linked = "󰈀 {ifname} (No IP)";
          format-disconnected = "󰖪 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}\n󰕒 {bandwidthDownBits} 󰕄 {bandwidthUpBits}";
          on-click = "nm-connection-editor";
        };

        "bluetooth" = {
          format = "󰂯 {status}";
          format-connected = "󰂱 {num_connections}";
          format-disabled = "󰂲";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "blueman-manager";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 {volume}%";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰄜";
            portable = "󰄜";
            car = "󰄋";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pwvucontrol";
          tooltip-format = "{desc}, {volume}%";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.95);
        color: #cdd6f4;
        border-bottom: 2px solid rgba(137, 180, 250, 0.5);
      }

      #workspaces button {
        padding: 0 10px;
        background: transparent;
        color: #cdd6f4;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
        background: rgba(137, 180, 250, 0.3);
        border-bottom: 3px solid #89b4fa;
        color: #89b4fa;
      }

      #workspaces button:hover {
        background: rgba(137, 180, 250, 0.2);
      }

      #workspaces button.urgent {
        background-color: #f38ba8;
        color: #1e1e2e;
      }

      #mode {
        background: #89b4fa;
        color: #1e1e2e;
        padding: 0 10px;
        font-weight: bold;
      }

      #window {
        padding: 0 10px;
        color: #cdd6f4;
        font-weight: 500;
      }

      #clock,
      #cpu,
      #memory,
      #temperature,
      #network,
      #bluetooth,
      #pulseaudio,
      #idle_inhibitor,
      #tray {
        padding: 0 12px;
        margin: 0 2px;
        background: rgba(49, 50, 68, 0.7);
        color: #cdd6f4;
      }

      #clock {
        background: rgba(137, 180, 250, 0.3);
        color: #89b4fa;
        font-weight: bold;
        padding: 0 15px;
      }

      #pulseaudio {
        background: rgba(166, 227, 161, 0.3);
        color: #a6e3a1;
      }

      #pulseaudio.muted {
        background: rgba(243, 139, 168, 0.3);
        color: #f38ba8;
      }

      #network {
        background: rgba(137, 220, 235, 0.3);
        color: #89dceb;
      }

      #network.disconnected {
        background: rgba(243, 139, 168, 0.3);
        color: #f38ba8;
      }

      #bluetooth {
        background: rgba(180, 190, 254, 0.3);
        color: #b4befe;
      }

      #bluetooth.disabled {
        background: rgba(88, 91, 112, 0.3);
        color: #585b70;
      }

      #cpu {
        background: rgba(245, 224, 220, 0.3);
        color: #f5e0dc;
      }

      #memory {
        background: rgba(203, 166, 247, 0.3);
        color: #cba6f7;
      }

      #temperature {
        background: rgba(250, 179, 135, 0.3);
        color: #fab387;
      }

      #temperature.critical {
        background: rgba(243, 139, 168, 0.5);
        color: #f38ba8;
        animation: blink 0.5s linear infinite;
      }

      #idle_inhibitor {
        background: rgba(245, 194, 231, 0.3);
        color: #f5c2e7;
      }

      #idle_inhibitor.activated {
        background: rgba(166, 227, 161, 0.3);
        color: #a6e3a1;
      }

      #tray {
        background: rgba(49, 50, 68, 0.5);
      }

      @keyframes blink {
        to {
          background-color: rgba(243, 139, 168, 0.8);
        }
      }
    '';
  };

  # Screen locker
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      show-failed-attempts = true;
    };
  };

  # Idle management
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { timeout = 600; command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\""; }
    ];
  };

  # Cursor theme
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Additional packages needed for Sway
  home.packages = with pkgs; [
    # Wayland utilities
    wl-clipboard      # Clipboard utilities
    grim              # Screenshot tool
    slurp             # Screen area selector
    wofi              # Application launcher (alternative: rofi-wayland)
    mako              # Notification daemon
    brightnessctl     # Brightness control
    playerctl         # Media player control

    # System control utilities
    pwvucontrol       # Modern PipeWire volume control
    blueman           # Bluetooth manager
    networkmanagerapplet  # Network manager applet (nm-applet)

    # Fonts
    # font-awesome      # For waybar icons
  ];
}
