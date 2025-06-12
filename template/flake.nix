{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		nixosBlankSystem.url = "github:fpekal-nixos/nixos-template";
		nixosBlankSystem.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs =
		{ self, nixosBlankSystem, ... }:
		{
			systems.minimal = nixosBlankSystem.systems.blank.extend { modules = [ ./modules ./overlays ./packages ./users ./hosts ./shells ./options ]; };

			nixosConfigurations.default = self.systems.minimal.mksystem { system = "x86_64-linux"; };
		};
}

