{
  programs.alacritty = {
    enable = true;
    
    settings = {
      window = {
	dynamic_title = true;
	padding = {
	  x = 0;
	  y = 0;
	};
	startup_mode = "Maximized";
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
