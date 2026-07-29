{...}: {
  imports = [
    ./locale.nix
    ./programs.nix
    ./services.nix
    ./hardware-configuration.nix

    ../../modules/hardware/fingerprint.nix
    ../../modules/networking/netbird-tailscale.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "makima";
  time.timeZone = "Indian/Antananarivo";

  # Tailscale stays on here alongside NetBird; see programs.nix for how the
  # two are kept from fighting over 100.64.0.0/10.

  system.stateVersion = "26.05"; # Did you read the comment?
}
