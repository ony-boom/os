{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.kdePackages.qtmultimedia
  ];

  services.displayManager.sddm = {
    enable = true;
  };

  programs.silentSDDM = {
    enable = true;
    theme = "silent";
  };
}
