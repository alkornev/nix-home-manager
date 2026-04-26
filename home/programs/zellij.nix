{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false; # auto-start managed manually in zsh.nix
    settings = {
      theme = "nord"; # or "nord", "gruvbox-dark", "dracula"
      default_shell = "zsh";
      pane_frames = false; # cleaner look without borders
    };
  };
}
