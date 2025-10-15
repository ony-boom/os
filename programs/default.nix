{
  pkgs,
  stable-pkgs,
  ...
}: {
  imports = [
    ./hyprland
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
      bottom

      gnome-themes-extra

      gnumake # make
      stow # for dotfiles because hm is annoying

      nautilus # file manager
      shotwell
      cheese

      emote
      icon-library
      google-chrome

      ghostty

      yaak
      zed-editor

      # indicator-sound-switcher
      swoosh
      pavucontrol

      vlc
      spotify
      obs-studio

      scrcpy
      wl-clipboard

      playerctl

      vicinae
    ]
    ++ (
      with stable-pkgs; [
        lmms
      ]
    );

  programs = {
    zoom-us.enable = true;
    seahorse.enable = true;
    kdeconnect.enable = true;
    # firefox.enable = true;
    nm-applet.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    git.enable = true;
  };
}
