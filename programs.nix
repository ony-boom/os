{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    curl

    gnumake # make
    stow # for dotfiles

    nautilus # file manager
    fuzzel # app launcher

    google-chrome

    eza # ls replacement
    starship # prompt

    ghostty
    zed-editor

    gcc # because vim need it

    swww
    dconf-editor
  ];

 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
    dconf.enable = true;
    git.enable = true;
    zoxide.enable = true;
    lazygit.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = true;
      # autosuggestions.enable = true;
      syntaxHighlighting.enable = true;    
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      package = inputs.neovim-nightly.packages.${pkgs.system}.default;
    };

    hyprland.enable = true;
  };
}
