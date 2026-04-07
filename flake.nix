{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    swoosh = {
      url = "github:ony-boom/swoosh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    vicinae.url = "github:vicinaehq/vicinae";
  };

  nixConfig = {
    extra-subtituters = [
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    stable-pkgs = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.maki = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit self inputs stable-pkgs;};
      modules = [
        {
          nixpkgs.overlays = [
            inputs.vicinae.overlays.default
            inputs.agenix.overlays.default
          ];
        }

        inputs.agenix.nixosModules.default
        inputs.swoosh.nixosModules.default
        inputs.silentSDDM.nixosModules.default

        ./config
        ./programs
        ./hardware-configuration.nix
      ];
    };
  };
}
