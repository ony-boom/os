{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    eza # ls but wit icons
    starship # prompt

    gh # github cli tool
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
