{pkgs, ...}: let
  # Work mesh, alongside personal Tailscale -- ./default.nix carries the truce
  # that keeps both usable inside 100.64.0.0/10. resolved stays the single DNS
  # backend (hence handing NetworkManager over to it) because both daemons
  # register their search domains per link over D-Bus rather than rewriting
  # resolv.conf, so neither has to win.
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
