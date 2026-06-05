{
  imports = [
    ./locale.nix
    ./env.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "makima";
  time.timeZone = "Indian/Antananarivo";

  system.stateVersion = "26.05"; # Did you read the comment?
}
