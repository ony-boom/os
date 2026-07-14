{pkgs, ...}: let
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
