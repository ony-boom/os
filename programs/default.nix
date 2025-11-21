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
      pavucontrol

      vlc
      spotify
      obs-studio
      gimp2
      kdePackages.kdenlive
      blanket
      # davinci-resolve

      scrcpy
      wl-clipboard

      playerctl

      agenix
      matugen
      vicinae

      zapzap
      quickemu # emu
    ]
    ++ (
      with stable-pkgs; [
        lmms
      ]
    );

  programs = {
    swoosh.enable = true;
    seahorse.enable = true;
    kdeconnect.enable = true;
    # firefox.enable = true;
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
