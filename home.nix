{ lib, pkgs, ... }: let 
  username = "aalkornev";
in {

  imports = [
    ./modules/zsh.nix
    ./modules/git.nix
  ];

  home = {
    packages = [
      pkgs.home-manager
      pkgs.htop
      pkgs.neovim
    ];
    
    inherit username; 
    homeDirectory = "/home/${username}";
   
    stateVersion = "25.11";
  };
}
