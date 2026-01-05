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
    ./game.nix
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
      # icon-library
      google-chrome
      zen-browser

      ghostty

      zed-editor

      blueberry
      pavucontrol

      vlc
      spotify
      obs-studio
      gimp2
      kdePackages.kdenlive

      feishin
      nicotine-plus

      scrcpy
      wl-clipboard

      playerctl

      agenix
      vicinae

      quickemu # VM and stuff
      jetbrains.webstorm
    ]
    ++ (
      with stable-pkgs; [
        bruno
      ]
    );

  programs = {
    adb.enable = true;
    swoosh.enable = true;
    seahorse.enable = true;
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
