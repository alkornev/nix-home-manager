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
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
