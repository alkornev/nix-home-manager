{
  description = "My home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    darwin = {
      url ="github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      username = "aalkornev";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations.desktop = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/desktop ];
        specialArgs = {
          inherit username;
        };
      };

      # Standalone home-manager configuration
      homeConfigurations = {
        "${username}@desktop" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ./home/linux.nix ];
          extraSpecialArgs = {
            inherit username;
          };
        };
      };
    };
}
