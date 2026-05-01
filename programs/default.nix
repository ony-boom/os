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
      wget
      curl
      ffmpeg
      p7zip
      peazip

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

      blueman
      pavucontrol

      vlc
      spotify
      obs-studio

      feishin

      wl-clipboard

      playerctl

      agenix
      vicinae

      jetbrains.webstorm
      android-studio
      onlyoffice-desktopeditors
      android-tools
    ]
    ++ (
      with stable-pkgs; [
        gimp2
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
