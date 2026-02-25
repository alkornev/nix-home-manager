{ pkgs, ... }:
{

  home = {
    packages = [
      pkgs.home-manager
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

      pkgs.opencode
      pkgs.claude-code
    ];
  };
}
