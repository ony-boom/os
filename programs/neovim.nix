{pkgs, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    gcc
    tree-sitter
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly.packages.${pkgs.system}.default;
  };
}
