{
  stable-pkgs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      jetbrains-toolbox
      android-studio
      android-tools
    ]
    ++ (with stable-pkgs; [
      ardour
      gimp2
    ]);

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
