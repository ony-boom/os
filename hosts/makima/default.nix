{...}: {
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

  # Let containers on the cgtv-backoffice_cgtv-net docker bridge (172.28.0.0/16,
  # br-42e373dcd017) reach a service listening on the host's port 3000. Written
  # against the subnet rather than networking.firewall.interfaces.<br-…> because
  # the bridge name is derived from the docker network id and changes whenever
  # the network is recreated; the subnet is pinned by the compose file.
  networking.firewall.extraCommands = ''
    iptables -I nixos-fw -p tcp -s 172.28.0.0/16 --dport 3000 -j nixos-fw-accept
  '';
  networking.firewall.extraStopCommands = ''
    iptables -D nixos-fw -p tcp -s 172.28.0.0/16 --dport 3000 -j nixos-fw-accept || true
  '';

  # NetBird (work) and Tailscale (personal) share 100.64.0.0/10, and ts-input
  # drops CGNAT traffic that isn't on tailscale0 -- killing NetBird on wt0.
  # Off takes that rule with it, plus the `-i tailscale0 -j ACCEPT` below it.
  services.tailscale.extraSetFlags = ["--netfilter-mode=off"];
  networking.firewall.trustedInterfaces = ["tailscale0"];

  system.stateVersion = "26.05"; # Did you read the comment?
}
