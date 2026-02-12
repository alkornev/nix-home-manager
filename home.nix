{ lib, pkgs, ... }:
let
  username = "aalkornev";
  modulePaths = lib.fileset.toList (lib.fileset.fileFilter (file: file.hasExt "nix") ./modules);
in
{
  imports = lib.traceSeq modulePaths modulePaths;
  #[
  #./modules/*.nix
  #./modules/zsh.nix
  # ./modules/git.nix
  # ./modules/starship.nix
  #./modules/fonts.nix
  #];
  # home.sessionVariables = {
  #   SHELL = "${pkgs.zsh}/bin/zsh";
  # };

  home = {
    packages = [
      pkgs.home-manager
      pkgs.htop
      pkgs.nixfmt
      pkgs.cargo
      pkgs.tealdeer
    ];

    inherit username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

    stateVersion = "25.11";
  };
}
