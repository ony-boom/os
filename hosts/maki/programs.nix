{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feishin
    jetbrains-toolbox
    gimp
    glab
    video-downloader
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
}
