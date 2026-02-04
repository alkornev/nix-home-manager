{ lib, pkgs, ... };
{
  home = {
    packages = with pkgs; [
      hello
    ];
    
    username = "aalkornev";
    homeDirectory = "/home/aalkornev";
    

    stateVersion = "25.11";
  };
}
