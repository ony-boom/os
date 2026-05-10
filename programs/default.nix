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

      # emote
      # icon-library
      google-chrome

      ghostty

      pavucontrol

      vlc
      spotify
      obs-studio
      obsidian

      feishin
      trayscale
      vicinae
      wl-clipboard

      playerctl

      agenix

      jetbrains.webstorm
      android-studio
      onlyoffice-desktopeditors
      android-tools
      zed-editor
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
