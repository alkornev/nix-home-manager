{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{

  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # optional: adds a `docker` alias
    defaultNetwork.settings.dns_enabled = true;
  };

  # environment.etc."containers/policy.json".text = builtins.toJSON {
  #   default = [{ type = "insecureAcceptAnything"; }];
  # };

  virtualisation.containers.registries.search = [ "docker.io" ];

  boot.kernelModules = [ "kvm-amd" ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
  };

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-desktop # GUI for managing containers / pods / images
    docker-compose # start group of containers for dev
    #podman-compose # start group of containers for dev
    distrobox
    virtiofsd
    spice-gtk
  ];

  # CDI: `podman run --device nvidia.com/gpu=all ...` (rootless adds `--security-opt label=disable`)
  hardware.nvidia-container-toolkit.enable = true;
  users.users.${username} = {
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };
}
