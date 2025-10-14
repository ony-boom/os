{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swoosh = {
      url = "github:ony-boom/swoosh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    stable-pkgs = import inputs.nixpkgs-stable {inherit system;};
  in {
    nixosConfigurations.maki = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs stable-pkgs;};
      modules = [
        {
          nixpkgs.overlays = [
            inputs.vicinae.overlays.default
            (self: super: {
              swoosh = inputs.swoosh.packages.${system}.default;
            })
          ];
        }
        ./config
        ./programs
        ./hardware-configuration.nix
      ];
    };
  };
}
