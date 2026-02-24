{
  description = "My home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nixvim,
      ...
    }:
    let
      username = "aalkornev";
      lib = nixpkgs.lib;
    in
    {

      darwinConfigurations."intel-mac" = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [ ./hosts/darwin ];
        specialArgs = {
          inherit username;
        };
      };

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
          modules = [
            ./home/linux.nix
            nixvim.homeModules.nixvim
          ];
          extraSpecialArgs = {
            inherit username;
          };
        };

        "${username}@intel-mac" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [
            ./home/darwin.nix
            nixvim.homeModules.nixvim
          ];
          extraSpecialArgs = {
            inherit username;
          };
        };

      };
    };
}
