{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.autoSuspend = false;
  services.desktopManager.gnome.enable = true;

  # Let GNOME handle idle suspend exclusively; prevent logind from
  # re-suspending immediately after wake due to accumulated idle time.
  services.logind.settings.Login.IdleAction = "ignore";

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  # services.gnome.core-apps.enable = true;
  # services.gnome.core-developer-tools.enable = false;
  # services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.paperwm
  ];

  # Auto-enable extensions
  programs.dconf.enable = true;
}
