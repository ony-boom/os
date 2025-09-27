{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.maki = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };
  };
}
