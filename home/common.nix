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

      pkgs.discord
      pkgs.spotify

      pkgs.opencode
      pkgs.claude-code
    ];
  };
}
