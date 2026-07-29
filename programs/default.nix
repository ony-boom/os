{pkgs, ...}: {
  imports = [
    ./wm
    ./neovim.nix
    ./terminal.nix
    ./vm-stuff.nix
    ./programming.nix
    ./game.nix
  ];

  # base packages
  environment.systemPackages = with pkgs;
    [
      wget
      curl
      ffmpeg
      p7zip
      peazip

      # thumbnail things
      imagemagick
      ffmpegthumbnailer

      glow
      bottom

      gnumake # make
      chezmoi # for dotfiles because hm is annoying

      loupe
      cheese
      nautilus
      baobab
      gnome-disk-utility
      refine

      # Plain Chrome here; NVIDIA hosts patch it to force the X11/XWayland
      # backend via an overlay in modules/hardware/nvidia.nix (works around
      # broken VA-API decode under Chrome's native Wayland path).
      google-chrome

      ghostty

      pavucontrol

      vlc
      spotify
      discord

      trayscale
      vicinae
      wl-clipboard

      playerctl

      agenix

      zed-editor

      bruno
    ];

  # ponytail: on-demand, kept out of systemPackages. Every path in the system
  # closure is re-downloaded in full whenever unstable rerolls stdenv (~monthly),
  # so packages used occasionally cost far more in bandwidth than in disk.
  # `nix run nixpkgs#<name>` fetches them when needed — and gives a newer build
  # than the pinned system would.
  #
  #   obs-studio                 1.95 GB (bundles cef-binary)
  #   onlyoffice-desktopeditors  1.03 GB
  #
  # Move one back here the moment it becomes part of your daily loop.

  programs = {
    seahorse.enable = true;
    localsend.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
    git.enable = true;
  };
}
