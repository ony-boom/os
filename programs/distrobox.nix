{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    extraPackages = with pkgs; [
      docker-compose
    ];
  };

  virtualisation.podman.enable = true;
}
