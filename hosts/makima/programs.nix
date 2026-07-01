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
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  }
  // netbird
