{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.fenix.overlays.default];

  environment.systemPackages = with pkgs;
    [
      fenix.default.toolchain
      fenix.rust-analyzer
    ];
}
