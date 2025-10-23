{
  inputs,
  pkgs,
  ...
}: {
  qt.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${system}.default
  ];
}
