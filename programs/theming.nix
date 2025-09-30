{pkgs, ...}: let
  gtk-theme = pkgs.colloid-gtk-theme.override {
    tweaks = ["rimless" "black" "gruvbox"];
    themeVariants = ["default" "yellow" "orange" "grey"];
  };

  icon-theme = pkgs.colloid-icon-theme.override {
    schemeVariants = ["gruvbox"];
  };
in {
  environment.systemPackages = [
    gtk-theme
    icon-theme
  ];
}
