{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    quickemu # VM and stuff
  ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    extraPackages = with pkgs; [
      docker-compose
    ];
  };

  virtualisation.podman.enable = true;
}
