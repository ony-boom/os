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
      p7zip

      # thumbnail things
      imagemagick
      ffmpegthumbnailer

      bottom

      gnumake # make
      stow # for dotfiles because hm is annoying

      nemo
      loupe
      cheese
      gnome-disk-utility

      # emote
      # icon-library
      google-chrome

      ghostty

      zed-editor

      blueman
      pavucontrol

      vlc
      spotify
      obs-studio
      gimp2
      kdePackages.kdenlive

      feishin
      nicotine-plus

      wl-clipboard

      playerctl

      agenix
      vicinae

      jetbrains.webstorm
      android-studio
      onlyoffice-desktopeditors
    ]
    ++ (
      with stable-pkgs; [
        bruno
      ]
    );

  programs = {
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
    git.enable = true;
  };
}
