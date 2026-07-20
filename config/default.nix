# Shared system base — imported by every host via the flake. Host-specific
# bits (hostname, timezone, bootloader, disks, GPU) live under hosts/<name>/.
{pkgs, ...}: {
  imports = [
    ./nix.nix
    ./services
    ./env.nix
    ./user.nix
  ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  virtualisation.spiceUSBRedirection.enable = true;

  # On by default upstream; pulls speech-dispatcher + mbrola voices (~700 MiB).
  services.speechd.enable = false;

  security.polkit.enable = true;
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.hasklug
      nerd-fonts.iosevka
      maple-mono.NF
      openmoji-color
      twitter-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = ["Iosevka Nerd Font" "Maple Mono NF"];
      emoji = ["Twitter Color Emoji"];
    };
  };

  networking.firewall.allowedTCPPorts = [
    8080
    8081
  ];
  networking.firewall.allowedUDPPorts = [
    5353
  ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = ["com.mitchellh.ghostty.desktop"];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
