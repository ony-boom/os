{pkgs, ...}: let
  theme = pkgs.sddm-astronaut.override {
    embeddedTheme = "japanese_aesthetic";
  };
in {
  environment.systemPackages = [
    pkgs.kdePackages.qtmultimedia
  ];

  services.displayManager.sddm = {
    enable = true;

    extraPackages = [
      pkgs.sddm-astronaut
    ];

    theme = "${theme}/share/sddm/themes/sddm-astronaut-theme";
  };
}
