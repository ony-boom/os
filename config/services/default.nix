{lib, ...}: {
  imports = [
    ./gnome-keyring.nix
    ./sddm.nix
    ./profile-pic.nix
  ];
  # Enable touchpad support (enabled default in most desktopManager)
  # services.libinput.enable = true;

  # disks
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # ssh/remote things
  services.openssh.enable = true;
  services.tailscale.enable = lib.mkDefault true;

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

  services.flatpak.enable = true;

  # sound
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };
}
