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

      pkgs.discord
      pkgs.spotify
      pkgs.telegram-desktop
      pkgs.obsidian

      pkgs.opencode
      pkgs.claude-code
      pkgs.codex
    ];
  };
}
