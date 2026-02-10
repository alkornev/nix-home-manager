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
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
   
    stateVersion = "25.11";
  };
}
