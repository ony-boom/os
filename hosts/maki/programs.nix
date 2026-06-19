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
}
