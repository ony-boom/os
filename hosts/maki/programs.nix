{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feishin
    jetbrains-toolbox
    ardour
    gimp2
    spotiflac
    glab
    video-downloader
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
}
