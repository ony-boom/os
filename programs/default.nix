{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./neovim.nix
    ./terminal.nix
  ];

  # base packages
  environment.systemPackages = with pkgs; [
    wget
    curl

    gnumake # make
    stow # for dotfiles because hm is annoying

    nautilus # file manager
    fuzzel # app launcher

    google-chrome

    ghostty
    zed-editor
  ];

  programs = {
    dconf.enable = true;
    git.enable = true;
  };
}
