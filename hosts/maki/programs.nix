{stable-pkgs, pkgs, ...}: {
  environment.systemPackages = with stable-pkgs; [
    ardour
    gimp2
  ] ++ (with pkgs; [
      jetbrains-toolbox
      android-studio
      android-tools
  ]);


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
