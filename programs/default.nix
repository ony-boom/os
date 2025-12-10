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
      dig
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
      gnome-disk-utility

      # emote
      icon-library
      google-chrome
      zen-browser

      ghostty

      bruno
      zed-editor
      affine

      blueberry
      pavucontrol

      vlc
      spotify
      obs-studio
      gimp2
      kdePackages.kdenlive
      blanket

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
