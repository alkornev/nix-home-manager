{ lib, pkgs, ... }: let
  username = "aalkornev";
in {
  home = {
    packages = with pkgs; [
      hello
      home-manager
      nixfmt
    ];

    inherit username;
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

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
