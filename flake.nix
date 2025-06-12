{
  description = "A modular NixOS configuration flake template.";

  outputs = { self }: {
		templates = {
			default = {
				path = ./template;
			};
		};
  };
}
