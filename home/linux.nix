{ lib, pkgs, username, ... }:
{
  imports = [
    ./programs
    ./desktop
  ];

  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home = {
    packages = [
      pkgs.home-manager
      pkgs.htop
      pkgs.unzip
      pkgs.nixfmt
      pkgs.cargo
      pkgs.tealdeer
      pkgs.just

      pkgs.steam
      pkgs.discord
      pkgs.spotify

      pkgs.wineWow64Packages.waylandFull
      pkgs.winetricks
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };
}
