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
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };

}
