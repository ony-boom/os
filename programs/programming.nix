{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    fenix.stable
  ];
}
