{lib, ...}: {
  imports = [
    ./locale.nix
    ./programs.nix
    ./services.nix
    ./hardware-configuration.nix

    ../../modules/hardware/fingerprint.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "makima";
  networking.extraHosts = ''
    10.0.0.106 grafana.local.fluen.tech
  '';
  time.timeZone = "Indian/Antananarivo";

  # Override the shared services.tailscale.enable = true from ../../config.
  # NetBird (programs.nix) is the mesh on this host; Tailscale was only ever
  # here to make maki able to find and reach it, and mDNS in ../../config does
  # that on the LAN without a second VPN. modules/networking/netbird-tailscale.nix
  # stays in the tree, unimported, for whenever both need to run at once again.
  services.tailscale.enable = lib.mkForce false;

  system.stateVersion = "26.05"; # Did you read the comment?
}
