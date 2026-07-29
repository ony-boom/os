{pkgs, ...}: let
  # NetBird and Tailscale coexist on this host. Two things make that work:
  #
  #  - DNS: both drive systemd-resolved over D-Bus and register their own
  #    search domains per link, so neither clobbers the other's resolv.conf.
  #    That only holds while resolved is the single DNS backend, hence
  #    handing NetworkManager over to it too.
  #  - Routing: both allocate out of 100.64.0.0/10, and Tailscale grabs the
  #    whole block. netbirdTailscale carves NetBird's /16 back out.
  netbird = {
    services.netbird = {
      enable = true;
    };
    services.resolved.enable = true;
    networking.networkmanager.dns = "systemd-resolved";
    networking.netbirdTailscale.enable = true;
  };
in
  {
    # distrobox uses the podman/docker backends enabled in programs/vm-stuff.nix.
    environment.systemPackages = with pkgs; [
      obsidian
      distrobox
    ];
  }
  // netbird
