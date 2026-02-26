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
    ./desktop/ollama.nix
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
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11";
  };

}
