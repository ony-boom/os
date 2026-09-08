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

  # NetBird (work, ./programs.nix) and Tailscale (personal) both live inside
  # 100.64.0.0/10, and they only coexist once Tailscale stops policing that
  # range: its ts-input chain ends with `! -i tailscale0 -s 100.64.0.0/10 -j
  # DROP`, which eats every NetBird packet arriving on wt0. Turning netfilter
  # off drops the whole chain set rather than trying to poke a hole in it.
  #
  # Routing needs no help. On Linux tailscaled installs a /32 per peer in table
  # 52 -- the single 100.64.0.0/10 route is a macOS/Android optimisation -- so a
  # NetBird address misses table 52 and falls through to main, even though the
  # `ip rule` at 5270 sends it to table 52 first. Two cases still collide: a
  # Tailscale exit node, whose default route in table 52 swallows everything,
  # and a Tailscale peer holding the exact address of a NetBird peer.
  #
  # ts-input also *opened* with `-i tailscale0 -j ACCEPT`, which is what let
  # inbound tailnet traffic past the host firewall; trustedInterfaces is that
  # rule, restated in NixOS' own firewall now that Tailscale writes none.
  services.tailscale.extraSetFlags = ["--netfilter-mode=off"];
  networking.firewall.trustedInterfaces = ["tailscale0"];

  system.stateVersion = "26.05"; # Did you read the comment?
}
