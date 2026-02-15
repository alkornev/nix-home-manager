{
  programs.alacritty = {
    enable = true;
    settings.terminal.shell.program = "zsh";
    settings = {
      keyboard.bindings = [
        {
          key = "C";
          mods = "Control";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
      ];

      window = {
        dynamic_title = true;
        padding = {
          x = 0;
          y = 0;
        };
        # startup_mode = "Maximized";
        dimensions = {
          columns = 100;
          lines = 45;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        size = 20;
        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };
        normal = {
          family = "UbuntuMono Nerd Font Mono";
        };
      };

      selection = {
        save_to_clipboard = false;
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };
    };
  };
}
