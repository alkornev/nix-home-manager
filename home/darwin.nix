{ lib, pkgs, username, ... }:
{
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = [
      pkgs.home-manager
      pkgs.htop
      pkgs.unzip
      pkgs.nixfmt
      pkgs.cargo
      pkgs.tealdeer
      pkgs.just

      # pkgs.steam
      # pkgs.discord
      # pkgs.spotify
    ];

    inherit username;
    homeDirectory = "/Users/${username}";

    stateVersion = "25.11";
  };
}
