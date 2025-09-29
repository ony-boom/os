{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ripgrep
    eza # ls but wit icons
    starship # prompt

    gh # github cli tool

    openssl # some apps depends on it
  ];

  programs = {
    zoxide.enable = true;
    lazygit.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
