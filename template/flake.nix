{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		nixosBlankSystem.url = "github:fpekal-nixos/nixos-template";
		nixosBlankSystem.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs =
		{ self, nixosBlankSystem, ... }:
		{
			systems.my_system = nixosBlankSystem.systems.minimal.extend { modules = [ ./modules ./overlays ./packages ./users ./hosts ./shells ./options ]; };

			nixosConfigurations.default = self.systems.my_system.mksystem { system = "x86_64-linux"; specialArgs = { host = "nixos"; users = []; }; };
		};
}

