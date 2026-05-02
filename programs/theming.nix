{
  pkgs,
  inputs,
  ...
}: let
  gtk-theme = pkgs.colloid-gtk-theme.override {
    tweaks = ["rimless" "black" "catppuccin"];
    themeVariants = ["default"];
  };

  icon-theme = pkgs.colloid-icon-theme.override {
    schemeVariants = ["catppuccin"];
  };
in {
  programs.dms-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };
  environment.systemPackages =
    [
      gtk-theme
      icon-theme
    ]
    ++ (with pkgs; [
      adw-gtk3
    ]);
}
