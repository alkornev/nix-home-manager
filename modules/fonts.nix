{ pkgs, ... }:
{

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "UbuntuMono Nerd Font Mono" ];
      sansSerif = [ "UbuntuMono Nerd Font" ];
      serif = [ "UbuntuMono Nerd Font" ];
    };
  };

  home.packages = [
    # pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.ubuntu-sans
  ];
}
