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

  nix.settings = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Set your shell
  programs.zsh.enable = true;

  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility
  system.stateVersion = 6;
}
