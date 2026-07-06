{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
    android-studio
    android-tools
    ardour
    gimp2
  ];
}
