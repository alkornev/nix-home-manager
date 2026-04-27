{
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./programs
    ./desktop
    ./desktop/opencode.nix
    ./common.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };


  home = {
    packages = [
      pkgs.steam

      pkgs.wineWow64Packages.waylandFull
      pkgs.winetricks

      pkgs.libreoffice-fresh
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };

}
