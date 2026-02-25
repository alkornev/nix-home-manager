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
