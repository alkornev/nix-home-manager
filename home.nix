{ lib, pkgs, ... }: let 
  username = "aalkornev";
in {
  home = {
    packages = with pkgs; [
      hello
    ];
    
    inherit username; 
    homeDirectory = "/home/${username}";
    
    file = {
      "hello.txt" = {
        text = ''
          #!/usr/bin/env bash

          echo "Hello, ${username}!"
          echo '*slaps roof* This script can fit so many lines in it'
        '';
        executable = true;
      };
    };

    stateVersion = "25.11";
  };
}
