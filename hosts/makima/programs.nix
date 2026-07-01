{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    obsidian
    netbird-ui
  ];

  services.netbird = {
    enable = true;
    useRoutingFeatures = "both";

    # Pin the self-hosted management server declaratively so a fresh machine
    # registers against it instead of needing a manual `netbird up`.
    # These NB_* vars are read by the daemon (`netbird service run`).
    clients.default.environment = {
      NB_MANAGEMENT_URL = "https://netbird.fluen.tech";
      NB_ADMIN_URL = "https://netbird.fluen.tech";
    };

    # To auto-register on a fresh install: create a setup key in the dashboard,
    # write it to a file kept OUT of the nix store, then uncomment:
    # clients.default.login = {
    #   enable = true;
    #   setupKeyFile = "/etc/netbird/setup-key";
    # };
  };
  services.resolved.enable = true;
}
