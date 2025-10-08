{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jq
    ripgrep
    eza # ls but wit icons
    starship # prompt

    gh # github cli tool

    openssl # some apps depends on it
    yazi

    atuin
    fzf

    zsh-vi-mode
  ];

  # services.atuin.enable = true;

  programs = {
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
