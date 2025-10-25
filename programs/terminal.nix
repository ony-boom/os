{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    atuin
    eza # ls but wit icons
    starship # prompt
    cava
    fastfetch

    gh # github cli tool

    openssl # some apps depends on it
    yazi

    jq
    ripgrep
    fzf
    fd

    zsh-vi-mode
  ];

  # services.atuin.enable = true;

  programs = {
    mosh.enable = true;
    zoxide.enable = true;
    lazygit.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = true;
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
      syntaxHighlighting.enable = true;
    };
  };
}
