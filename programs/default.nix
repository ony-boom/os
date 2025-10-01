{pkgs, ...}: {
  imports = [
    ./hyprland
    ./theming.nix
    ./neovim.nix
    ./terminal.nix
    ./distrobox.nix
    ./programming.nix
  ];

  # base packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    bottom
    psmisc # utilities (killall)

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

    pavucontrol
    vlc
    spotify

    wl-clipboard
  ];

  programs = {
    nm-applet.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    git.enable = true;
  };
}
