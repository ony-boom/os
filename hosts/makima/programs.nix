{pkgs, ...}: let
  # Work mesh, next to personal Tailscale (see ./default.nix). resolved is the
  # single DNS backend -- hence NetworkManager handing over -- because both
  # daemons register search domains per link over D-Bus, so neither has to win.
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
