# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./cachix.nix
    ./gnome.nix
    ./nvidia.nix
    ./ollama.nix
    ./virtualization.nix
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "iommu=pt"
  ];

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  # Early AMD CPU microcode loading via initrd
  hardware.cpu.amd.updateMicrocode = true;

  # Load fan controller module for MSI MPG X870E CARBON WIFI (Nuvoton NCT6687D)
  boot.extraModulePackages = [ config.boot.kernelPackages.nct6687d ];
  boot.kernelModules = [ "nct6687" ];
  boot.extraModprobeConfig = ''
    softdep nct6687 pre: i2c_i801
    options nct6687 fan_config=msi_alt1 msi_fan_brute_force=1
  '';

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # clean up garbage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Xbox controller Bluetooth support
  hardware.xpadneo.enable = true;
  # services.blueman.enable = true;

  # Mystic Light / RAM / AIO RGB control
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # USB4 / Thunderbolt device authorization (ASMedia ASM4242)
  services.hardware.bolt.enable = true;

  # Sensor configuration to hide bogus readings
  environment.etc."sensors.d/custom.conf".text = ''
    # Ignore non-existent Thermistor 0 on nct6687 (shows -40°C, not physically connected)
    # Ignore M2_1 thermistor pad (shows 216°C — single-sided SSD, nothing for the pad to read)
    # Ignore unused System Fan headers #2, #3, #6 (no fans connected)
    chip "nct6687-*"
        ignore temp6
        ignore temp7
        ignore fan4
        ignore fan5
        ignore fan8
  '';

  # Enable udev rules for game controllers
  services.udev.packages = with pkgs; [ game-devices-udev-rules ];

  # Set your time zone
  time.timeZone = "Europe/Belgrade";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  security.sudo.wheelNeedsPassword = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "Aleksei";
    extraGroups = [
      "networkmanager"
      "wheel"
      "rtkit"
      "audio"
      "video"
      "render"
      "seat"
      "input"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # Use zsh system-wide
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Nix Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.trusted-users = [
    "root"
    username
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cachix
    git
    wget
    htop
    just
    direnv
    nvidia-container-toolkit
    pciutils
    mesa-demos
    wsdd
    lm_sensors
    nvme-cli
    smartmontools
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib # or libstdc++
      zlib
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.pulseaudio.enable = false; # Ensure this is false

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
