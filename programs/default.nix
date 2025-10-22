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
      bottom

      glib
      gsettings-desktop-schemas

      gnumake # make
      stow # for dotfiles because hm is annoying

      nautilus # file manager
      shotwell
      cheese

      # emote
      icon-library
      google-chrome

      ghostty

      bruno
      zed-editor
      obsidian

      # indicator-sound-switcher
      pavucontrol

      vlc
      spotify
      obs-studio

      scrcpy
      wl-clipboard

      playerctl

      vicinae
      prismlauncher
    ]
    ++ (
      with stable-pkgs; [
        lmms
      ]
    );

  programs = {
    swoosh.enable = true;
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
