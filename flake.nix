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

    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    vicinae.url = "github:vicinaehq/vicinae";

    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
            (prev: final: {
              matugen = inputs.matugen.packages.${system}.default;
              zen-browser = inputs.zen-browser.packages.${system}.default;
            })
          ];
        }

        inputs.agenix.nixosModules.default
        inputs.swoosh.nixosModules.default

        ./config
        ./programs
        ./hardware-configuration.nix
      ];
    };
  };
}
