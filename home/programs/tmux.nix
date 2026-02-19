{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    mouse = true;
    baseIndex = 1;
    extraConfig = ''
      # Status bar colors
      set -g status-style bg='#ff8c00',fg='#1e1e1e'

      # Active window tab
      set -g window-status-current-style bg='#ffaa00',fg='#1e1e1e',bold

      # Inactive window tabs
      set -g window-status-style bg='#cc6e00',fg='#1e1e1e'

      # Pane border
      set -g pane-border-style fg='#cc6e00'
      set -g pane-active-border-style fg='#ffaa00'

      # Command/message line
      set -g message-style bg='#ffaa00',fg='#1e1e1e'


      # Status bar
      set -g status on  # turn the status bar on
      set -g status-interval 5 # set update frequencey (default 15 seconds)
      set-option -g status-position top

      # Split panes
      bind -n M-d split-window -v  # Alt+d split down (horizontal)
      bind -n M-r split-window -h  # Alt+r split right (vertical)

      # Navigate panes with Alt+arrows (no prefix needed)
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Close pane
      bind -n M-x kill-pane

      # New window
      bind -n M-t new-window

      # Navigate windows
      bind -n M-[ previous-window
      bind -n M-] next-window

    '';
  };
}
