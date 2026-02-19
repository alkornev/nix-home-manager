{ config, pkgs, lib, username, ... }:
{

  virtualisation.containers.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;   # optional: adds a `docker` alias
    defaultNetwork.settings.dns_enabled = true;
  };

  # environment.etc."containers/policy.json".text = builtins.toJSON {
  #   default = [{ type = "insecureAcceptAnything"; }];
  # };

  virtualisation.containers.registries.search = [ "docker.io" ];

  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    #podman-compose # start group of containers for dev
  ];

  hardware.nvidia-container-toolkit.enable = true;
  users.users.${username} = {
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };
}
