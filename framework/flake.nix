{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs";
	};

	outputs =
	{ self, nixpkgs, }:
		let
			mksystem_func =
				{ _m, _s }:
				{ modules ? [], specialArgs ? {}, system }:
				nixpkgs.lib.nixosSystem {
					inherit system;

					modules = modules ++ _m;
					specialArgs = specialArgs // _s;
				};

			extend_func =
				{ _m, _s }:
				{
					extend = { modules ? [], specialArgs ? {} }: extend_func { _m = modules ++ _m; _s = specialArgs // _s; };
					mksystem = mksystem_func { inherit _m _s; };
				};

			blank_system = extend_func { _m = []; _s = {}; };

		in
		{
			systems.blank = blank_system;
			systems.minimal = self.systems.blank.extend { modules = [ ./modules ./overlays ./packages ./users ./hosts ./shells ./options ]; };

			nixosConfigurations = {
				default = self.systems.minimal.mksystem { system = "x86_64-linux"; };
			};
		};
}
