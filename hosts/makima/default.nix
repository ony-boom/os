{
  imports = [
    ./locale.nix
    ./env.nix
    ./programs.nix
    ./hardware-configuration.nix


    ../../modules/hardware/fingerprint.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "makima";
  time.timeZone = "Indian/Antananarivo";

  system.stateVersion = "26.05"; # Did you read the comment?
}
