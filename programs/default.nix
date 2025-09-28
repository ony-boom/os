{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./neovim.nix
    ./terminal.nix
    ./distrobox.nix
  ];

  # base packages
  environment.systemPackages = with pkgs; [
    wget
    curl

    gnumake # make
    stow # for dotfiles because hm is annoying

    nautilus # file manager

    emote
    google-chrome

    ghostty

    zed-editor
    vscode

    wl-clipboard
  ];

  programs = {
    dconf.enable = true;
    git.enable = true;
  };
}
