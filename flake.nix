{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    vicinae.url = "github:vicinaehq/vicinae";

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    dms.url = "github:AvengeMedia/DankMaterialShell";
    openscreen.url = "github:siddharthvaddem/openscreen";
  };

  nixConfig = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
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

    # Modules every host shares: external nixos modules, base overlays, and the
    # common system/program config. Per-host specifics (hardware, disks, GPU,
    # hostname) live under hosts/<name>/ and are added by mkHost.
    sharedModules = [
      {
        nixpkgs.overlays = [
          inputs.agenix.overlays.default
          (_: _: {
            zen-browser = inputs.zen-browser.packages."${system}".default;
          })
        ];
      }

      inputs.dms.nixosModules.dank-material-shell
      inputs.vicinae.nixosModules.default
      inputs.agenix.nixosModules.default
      inputs.silentSDDM.nixosModules.default
      inputs.openscreen.nixosModules.default

      ./config
      ./programs
    ];

    # Build a host from the shared base plus its hosts/<name>/ module.
    mkHost = hostName:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self inputs stable-pkgs;};
        modules = sharedModules ++ [./hosts/${hostName}];
      };
  in {
    nixosConfigurations = {
      maki = mkHost "maki";
      makima = mkHost "makima";
    };
  };
}
