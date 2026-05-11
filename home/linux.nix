{
  lib,
  pkgs,
  username,
  inputs,
  ...
}:
{
  imports = [
    ./programs
    ./desktop
    ./desktop/opencode.nix
    ./common.nix
    inputs.nix-index-database.homeModules.nix-index
  ];

  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.nix-index-database.comma.enable = true;


  home = {
    packages = [
      pkgs.steam

      pkgs.wineWow64Packages.waylandFull
      pkgs.winetricks

      pkgs.libreoffice-fresh

      pkgs.uutils-coreutils-noprefix

      pkgs.wl-clipboard
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };

}
