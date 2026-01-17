{pkgs, ...}: let
  gtk-theme = pkgs.colloid-gtk-theme.override {
    tweaks = ["rimless" "black" "catppuccin"];
    themeVariants = ["default"];
  };

  icon-theme = pkgs.colloid-icon-theme.override {
    schemeVariants = ["catppuccin"];
  };
in {
  environment.systemPackages = [
    gtk-theme
    icon-theme
  ];
}
