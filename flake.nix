{
  description = "NixOS configuration for nomshaz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nomshaz = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

        # Home Manager integration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.noorul = import ./home/noorul;
          home-manager.users.unreal = import ./home/unreal;
          home-manager.users.shaz = import ./home/shaz;
        }
      ];
    };
  };
}
