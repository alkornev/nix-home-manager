{ lib, pkgs, ... }: let 
  username = "aalkornev";
in {

  imports = [
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/starship.nix
    ./modules/fonts.nix
  ];

  home = {
    packages = [
      pkgs.home-manager
      pkgs.htop
      pkgs.neovim
      pkgs.alacritty
    ];
    
    inherit username; 
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
   
    stateVersion = "25.11";
  };
}
