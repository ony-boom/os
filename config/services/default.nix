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

  # mDNS, so hosts find each other on the LAN by name without a VPN in the way.
  # This is what makes `make push-makima HOST=makima.local` keep working across
  # DHCP lease changes -- makima has Tailscale off (it runs NetBird instead), so
  # MagicDNS is not there to resolve it, and a bare 192.168.88.x is a lease that
  # moves. publish.addresses is the half that answers queries; nssmdns4 is the
  # half that asks, and both hosts need both to resolve each other.
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
