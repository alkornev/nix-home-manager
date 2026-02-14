{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  # services.gnome.core-apps.enable = true;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.pop-shell
  ];

  # Auto-enable extensions
  programs.dconf.enable = true;
}
