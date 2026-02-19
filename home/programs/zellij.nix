{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;  # auto-start zellij in zsh
    settings = {
      theme = "nord";  # or "nord", "gruvbox-dark", "dracula"
      default_shell = "zsh";
      pane_frames = false;  # cleaner look without borders
      scrollback_lines = 10000;
    };
  };
}
