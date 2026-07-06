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
      # browserSupport drags in a 2 GiB CEF (full Chromium) just for OBS
      # browser sources.
      (obs-studio.override {browserSupport = false;})
      discord

      feishin
      trayscale
      vicinae
      wl-clipboard

      playerctl

      agenix

      onlyoffice-desktopeditors
      zed-editor

      bruno
    ];

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
