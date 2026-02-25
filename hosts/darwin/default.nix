{ pkgs, username, ... }:
{
  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    orbstack
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "intel-mac"; # Define your hostname.

  # users.users.${username} = {
  #   home = "/Users/${username}";
  # };

  # macOS-specific settings
  # system.defaults.dock.autohide = true;
  # system.defaults.finder.AppleShowAllExtensions = true;

  # Enable nix-daemon
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your shell
  programs.zsh.enable = true;

  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility
  system.stateVersion = 6;
}
