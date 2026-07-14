{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feishin
    jetbrains-toolbox
    android-studio
    android-tools
    ardour
    gimp2
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
}
