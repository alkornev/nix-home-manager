{
  config,
  pkgs,
  username,
  ...
}:
{
  # ─── Imports ────────────────────────────────────────────────
  imports = [
    ./cachix.nix
    ./gnome.nix
    ./nix-ld.nix
    ./nvidia.nix
    ./ollama.nix
    ./system-tools.nix
    ./virtualization.nix
    /etc/nixos/hardware-configuration.nix
  ];

  # ─── Nix / nixpkgs ──────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store   = true;
    keep-outputs          = true;
    keep-derivations      = true;
    trusted-users         = [ "root" "@wheel" ];
  };

  programs.nh = {
    enable = true;
    flake = "/home/${username}/nix-home-manager";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };

  # ─── Boot & kernel ──────────────────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  boot.supportedFilesystems = [ "ntfs" ]; # Windows dual-boot / external drives

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.blacklistedKernelModules = [ "amdgpu" "radeon" "nct6683" ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "iommu=pt"
    "amd_pstate=active"
  ];

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "32G";

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  # Fan controller for MSI MPG X870E CARBON WIFI (Nuvoton NCT6687D):
  # softdep ensures i2c_i801 loads first; msi_alt1 selects the right fan layout.
  boot.extraModulePackages = [ config.boot.kernelPackages.nct6687d ];
  boot.kernelModules = [ "nct6687" "k10temp" ];
  boot.extraModprobeConfig = ''
    softdep nct6687 pre: i2c_i801
    options nct6687 fan_config=msi_alt1 msi_fan_brute_force=1
    options kvm_amd nested=1
  '';

  # ─── Hardware ───────────────────────────────────────────────
  hardware.cpu.amd.updateMicrocode       = true;
  hardware.enableAllFirmware             = true;
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable                  = true;

  powerManagement.cpuFreqGovernor = "performance";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  services.fstrim.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;       # LE Audio, BAP, battery reporting
        KernelExperimental = true;
        FastConnectable = true;
      };
      Policy.AutoEnable = true;    # auto-reconnect known devices on resume/boot
    };
  };

  # Bridge AVRCP commands from BT headphones (AirPods taps, etc.) to MPRIS
  # so play/pause from the earbuds reaches GNOME media players.
  # mpris-proxy.service is shipped by bluez; we just enable it.
  systemd.user.services.mpris-proxy.wantedBy = [ "default.target" ];

  hardware.xpadneo.enable = true; # Xbox controller Bluetooth support

  # Mystic Light / RAM / AIO RGB control
  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  # USB4 / Thunderbolt device authorization (ASMedia ASM4242)
  services.hardware.bolt.enable = true;

  services.udev.packages = with pkgs; [ game-devices-udev-rules ];

  # ─── Networking ─────────────────────────────────────────────
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  # Local network discovery (mDNS): printers, GsConnect peers, `host.local` hostnames.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  # ─── Audio ──────────────────────────────────────────────────
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # High-quality BT audio codecs (SBC-XQ, mSBC, AAC, hardware volume).
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.codecs" = [
          "aac"
          "sbc"
          "sbc_xq"
          "aptx"
          "aptx_hd"
          "ldac"
        ];
        "bluez5.roles" = [
          "hsp_hs"
          "hsp_ag"
          "hfp_hf"
          "hfp_ag"
        ];
      };
    };
  };

  services.pulseaudio.enable = false;

  # ─── Locale & input ─────────────────────────────────────────
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  # ─── Users & shells ─────────────────────────────────────────
  security.sudo.wheelNeedsPassword = false;

  users.users.${username} = {
    isNormalUser = true;
    description = "Aleksei";
    extraGroups = [
      "audio"
      "input"
      "kvm"
      "libvirtd"
      "networkmanager"
      "render"
      "rtkit"
      "seat"
      "video"
      "wheel"
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # ─── Desktop apps / system programs ─────────────────────────
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ username ];
  };

  services.power-profiles-daemon.enable = true;
  services.dbus.implementation = "broker";

  # ─── System packages ────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    cachix
    git
    wget
    direnv
    nvidia-container-toolkit
    pciutils
    usbutils
    inxi
    btop
    vulkan-tools
    libva-utils

    file
    ripgrep
    jq
    tree
    dconf-editor

    mesa-demos
    wsdd
    lm_sensors
    nvme-cli
    smartmontools
  ];

  # Wayland / NVIDIA / VA-API hints for browsers and the compositor.
  environment.sessionVariables = {
    NIXOS_OZONE_ML          = "1";
    MOZ_ENABLE_WAYLAND      = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    __GL_GSYNC_ALLOWED      = "1";
    __GL_VRR_ALLOWED        = "1";
  };

  # ─── System state ───────────────────────────────────────────
  system.stateVersion = "25.11";
}
