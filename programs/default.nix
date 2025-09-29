{pkgs, ...}: {
  imports = [
    ./hyprland.nix
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

    emote
    google-chrome

    ghostty

    yaak
    zed-editor
    vscode

    wl-clipboard
  ];

  programs = {
    nm-applet.enable = true;
    nix-ld.enable = true;
    dconf.enable = true;
    git.enable = true;
  };
}
