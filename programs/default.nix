{
  pkgs,
  stable-pkgs,
  ...
}: {
  imports = [
    ./wm
    ./theming.nix
    ./neovim.nix
    ./terminal.nix
    ./vm-stuff.nix
    ./game.nix
    ./programming.nix
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
      stow # for dotfiles because hm is annoying

      loupe
      cheese
      nautilus
      baobab
      gnome-disk-utility

      # NVIDIA's VA-API/NVDEC decode is broken under Chrome's native Wayland
      # backend (vaEndPicture "internal decoding error" -> CPU-bound software
      # decode on 1080p+ video). Forcing the X11/XWayland path restores working
      # GPU decode. Covers every launch (menu, terminal, scripts).
      (google-chrome.override {
        commandLineArgs = ["--ozone-platform=x11"];
      })

      ghostty

      pavucontrol

      vlc
      spotify
      obs-studio
      discord

      feishin
      trayscale
      vicinae
      wl-clipboard

      playerctl

      agenix

      jetbrains-toolbox
      android-studio
      onlyoffice-desktopeditors
      android-tools
      zed-editor
      zen-browser
    ]
    ++ (
      with stable-pkgs; [
        gimp2
        bruno
      ]
    );

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
