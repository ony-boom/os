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
    ./distrobox.nix
    ./programming.nix
    ./steam.nix
  ];

  # base packages
  environment.systemPackages = with pkgs;
    [
      wget
      curl
      ffmpeg

      # thumbnail things
      imagemagick
      ffmpegthumbnailer

      bottom

      gnumake # make
      stow # for dotfiles because hm is annoying

      nautilus # file manager
      shotwell
      cheese

      # emote
      icon-library
      google-chrome
      zen-browser

      ghostty

      bruno
      zed-editor
      affine

      # indicator-sound-switcher
      blueberry
      pavucontrol

      vlc
      spotify
      obs-studio
      gimp2
      # pinta
      kdePackages.kdenlive
      blanket
      # davinci-resolve

      scrcpy
      wl-clipboard

      playerctl

      agenix
      matugen
      vicinae

      quickemu # VM and stuff
    ]
    ++ (
      with stable-pkgs; [
        lmms
      ]
    );

  programs = {
    swoosh.enable = true;
    seahorse.enable = true;
    # firefox.enable = true;
    localsend.enable = true;
    nm-applet.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
    dconf.enable = true;
    git.enable = true;
  };
}
