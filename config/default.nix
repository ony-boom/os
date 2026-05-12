{pkgs, ...}: {
  imports = [
    ./age.nix
    ./nix.nix
    ./nvidia.nix
    ./services
    ./env.nix
    ./user.nix
    ./boot.nix
    ./fs.nix
  ];
  networking.hostName = "maki"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Set your time zone.
  time.timeZone = "Indian/Antananarivo";

  security.polkit.enable = true;
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.hasklug
      maple-mono.NF
    ];
    fontconfig.defaultFonts = {
      monospace = ["Maple Mono NF"];
    };
  };

  networking.firewall.allowedTCPPorts = [
    8080
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

  system.stateVersion = "25.05"; # Did you read the comment?
}
