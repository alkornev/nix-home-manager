{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];
    
    username = "aalkornev";
    homeDirectory = "/home/aalkornev";
    
    file = {
      "hello.txt" = {
        text = ''
          #!/usr/bin/env bash

          echo "Hello, World!"
          echo '*slaps roof* This script can fit so many lines in it'
        '';
        executable = true;
      };
    };

    stateVersion = "25.11";
  };
}
