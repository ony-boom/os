{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./hardware-configuration.nix
  ];

  nix.settings = {
    substituters = ["https://walker.cachix.org"];
    trusted-public-keys = ["walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "maki"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Indian/Antananarivo";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.ony = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$faLiVjJgTMyExiZ1$4rmYx.HL1RRxxCI6CCfOOZ5M8VuwZSC6mPmVxmnxJliyXGYMFwDHDx40XPAv1NilOCvlj6jMFgq9bJqpoqGhj/";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.polkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.tailscale.enable = true;
  services.gvfs.enable = true;

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hasklug
    ];
    fontconfig.defaultFonts = {
      monospace = ["Hasklug Nerd Font Mono"];
    };
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    ZDOTDIR = "$XDG_CONFIG_HOME/zsh";
  };

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
