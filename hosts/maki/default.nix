# maki — NVIDIA desktop.
#
# Host-specific entry point: pulls in this machine's hardware, disks, and
# bootloader, opts into the hardware modules it needs, and sets the few values
# that differ per machine. The shared base (../../config + ../../programs) is
# imported by the flake for every host.
{
  imports = [
    ./hardware-configuration.nix
    ./fs.nix
    ./boot.nix
    ./programs.nix

    # Opt-in hardware: maki has an NVIDIA GPU. A non-NVIDIA host omits this.
    ../../modules/hardware/nvidia.nix
  ];

  networking.hostName = "maki";
  time.timeZone = "Indian/Antananarivo";

  system.stateVersion = "25.05"; # Did you read the comment?
}
