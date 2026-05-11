{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];

  # `,` lets you run a command without installing (e.g. `, cowsay hi`)
  programs.nix-index-database.comma.enable = true;

  # `locate` command
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  programs.mtr.enable = true;
  programs.fuse.userAllowOther = true;
  documentation.man.cache.enable = true;

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    rsync
    lsof
    strace
    ltrace
    iotop
    iftop
    nethogs
    dnsutils
    whois
    traceroute
    xdg-utils
    ethtool
    tcpdump
    pwgen
  ];
}
