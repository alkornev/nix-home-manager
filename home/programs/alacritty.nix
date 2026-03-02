{
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = {
        program = "zellij";
      };

      # keyboard.bindings = [
      #   {
      #     key = "C";
      #     mods = "Super";
      #     action = "Copy";
      #   }
      #   {
      #     key = "V";
      #     mods = "Super";
      #     action = "Paste";
      #   }
      # ];

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
        size = 18;
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
