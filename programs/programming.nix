{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.fenix.overlays.default];

  environment.systemPackages = with pkgs;
    [
      webhook

      fenix.default.toolchain
      fenix.rust-analyzer
    ];
}
