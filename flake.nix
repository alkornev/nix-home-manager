{
  description = "My home manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = {
        linux = "x86_64-linux";
        darwin = "x86_64-darwin";
      };

      mkHomeConfig =
        system: extraModules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [ ./home.nix ] ++ extraModules;
        };

    in
    {
      homeConfigurations = {
        "aalkornev@Darwin" = mkHomeConfig system.darwin [ ./os/darwin.nix ];
        "aalkornev@Linux" = mkHomeConfig system.linux [ ./os/linux.nix ];
      };
    };
}
