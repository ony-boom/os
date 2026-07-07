{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    feishin
    jetbrains-toolbox
    android-studio
    android-tools
    ardour
    gimp2
  ];
}
