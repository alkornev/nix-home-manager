{ pkgs, ... }:
{

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "UbuntuMono Nerd Font Mono" ];
      sansSerif = [ "Ubuntu Nerd Font" ];
      serif = [ "Ubuntu Nerd Font" ];
    };
  };

  home.packages = [
    # pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.ubuntu-sans
  ];
}
