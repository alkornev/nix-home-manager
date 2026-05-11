{ pkgs, ... }:
{

  home = {
    packages = [
      pkgs.home-manager
      pkgs.devenv
      pkgs.htop
      pkgs.unzip
      pkgs.nixfmt
      pkgs.cargo
      pkgs.tealdeer
      pkgs.just
      pkgs.fd
      pkgs.fzf
      pkgs.ffmpeg

      pkgs.bat
      pkgs.eza
      pkgs.dust
      pkgs.duf
      pkgs.procs
      pkgs.hexyl
      pkgs.hyperfine
      pkgs.sd

      pkgs.discord
      pkgs.spotify
      pkgs.telegram-desktop
      pkgs.obsidian

      pkgs.opencode
      pkgs.claude-code
      pkgs.codex
    ];
  };

  programs.bat.enable = true;
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
