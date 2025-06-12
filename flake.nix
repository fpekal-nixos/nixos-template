{
  description = "A modular NixOS configuration flake template.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs";
		framework.url = "./framework";
		framework.inputs.nixpkgs.follows = "nixpkgs";
	};

  outputs = { framework, ... }: {
		templates = {
			default = {
				path = ./template;
			};
		};
  } // framework;
}
