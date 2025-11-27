{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    extraPackages = with pkgs; [
      (
        sddm-astronaut.override
        {
          embeddedTheme = "japanese_aesthetic";
        }
      )
    ];

    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
  };
}
