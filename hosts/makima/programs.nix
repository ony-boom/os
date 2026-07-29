{pkgs, ...}: let
  # NetBird is the only mesh here -- Tailscale is off in default.nix -- so
  # nothing contends for 100.64.0.0/10 or for DNS. resolved stays the single
  # backend (hence handing NetworkManager over to it) because NetBird registers
  # its search domains per link over D-Bus rather than rewriting resolv.conf.
  # If Tailscale ever comes back, re-import modules/networking/netbird-tailscale.nix
  # and set networking.netbirdTailscale.enable there.
  netbird = {
    services.netbird = {
      enable = true;
    };
    services.resolved.enable = true;
    networking.networkmanager.dns = "systemd-resolved";
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
