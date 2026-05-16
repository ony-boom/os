{
  pkgs,
  inputs,
  ...
}: {
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
    adwaita-icon-theme
    tela-icon-theme
    hicolor-icon-theme
  ];
}
