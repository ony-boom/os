{
  imports = [
    ./gnome-keyring.nix
  ];
  # Enable touchpad support (enabled default in most desktopManager)
  # services.libinput.enable = true;

  # disks
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # ssh/remote things
  services.openssh.enable = true;
  services.tailscale.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # keyboard
    xkb = {
      layout = "us,us";
      variant = ",intl";
      options = "grp:win_space_toggle";
    };
  };

  services.displayManager.gdm = {
    enable = true;
  };
  services.flatpak.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
