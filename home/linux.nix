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

  nix.settings = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dde0+54S/C5/8/96zVcy7d/53IXVNL904="
    ];
  };

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
