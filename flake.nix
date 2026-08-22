{
  description = "immutaboy's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";

    };

#    noctalia = {
#	url = "github:noctalia-dev/noctalia";
#	inputs.nixpkgs.follows = "nixpkgs-unstable";
#    };
#    mangowc = {
#	url = "github:mangowm/mango";
#	inputs.nixpkgs.follows = "nixpkgs-unstable";
#	};


#    oxwm = {
#	url = "github:tonybanters/oxwm";
#	inputs.nixpkgs.follows = "nixpkgs-unstable";
#    };
};


  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
#	./noctalia.nix
#	./mango.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.immutaboy = import ./home.nix;
	    extraSpecialArgs = { inherit inputs; };
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
