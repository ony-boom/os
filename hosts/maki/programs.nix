{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feishin
    jetbrains-toolbox
    # ponytail: android-studio (3.4 GB) is on-demand — `nix run nixpkgs#android-studio`.
    # Anything in systemPackages is re-downloaded in full on every unstable stdenv
    # reroll, so occasional-use giants stay out of the closure. Put it back if you
    # start opening it daily.
    android-tools
    ardour
    gimp2
    spotiflac
    glab
    video-downloader
  ];

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
}
