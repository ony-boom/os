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

  # mDNS, so hosts find each other on the LAN by name without a VPN in the way:
  # `make push-makima HOST=makima.local` survives DHCP leases moving. publish
  # answers queries, nssmdns4 asks, and both hosts need both.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };

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

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };
}
