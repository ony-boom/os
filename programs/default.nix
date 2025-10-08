{pkgs, ...}: {
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
  environment.systemPackages = with pkgs; [
    wget
    curl
    bottom
    psmisc # utilities (killall)

    gnome-themes-extra

    gnumake # make
    stow # for dotfiles because hm is annoying

    nautilus # file manager
    shotwell
    cheese

    emote
    google-chrome

    ghostty

    yaak
    zed-editor

    indicator-sound-switcher
    pavucontrol

    vlc
    spotify
    obs-studio

    scrcpy
    wl-clipboard

    lmms
  ];

  programs = {
    seahorse.enable = true;
    kdeconnect.enable = true;
    # localsend.enable = true;
    firefox.enable = true;
    nm-applet.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    git.enable = true;
  };
}
