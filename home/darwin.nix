{
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./programs
    ./common.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dde0+54S/C5/8/96zVcy7d/53IXVNL904="
    ];
  };

  targets.darwin.defaults = {
    NSGlobalDomain = {
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
    };
  };

  home = {
    packages = [
    ];

    inherit username;
    homeDirectory = "/Users/${username}";

    stateVersion = "25.11";
  };
}
