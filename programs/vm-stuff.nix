{pkgs, ...}: {
  # ponytail: quickemu is on-demand — `nix run nixpkgs#quickemu`. It drags qemu
  # (0.94 GB) into the closure, which is a lot to re-download monthly for a tool
  # you reach for a few times a year.
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    extraPackages = with pkgs; [
      docker-compose
    ];
  };

  virtualisation.podman.enable = true;
}
