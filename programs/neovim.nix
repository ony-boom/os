{
  pkgs,
  inputs,
  ...
}: let
  lsp = with pkgs; [
    nil
    nixd

    biome
    lua-language-server

    emmet-language-server
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted

    python313Packages.python-lsp-server
  ];

  formatter = with pkgs; [
    stylua
    alejandra
    prettierd
  ];
in {
  environment.systemPackages = with pkgs;
    [
      gcc
      tree-sitter
    ]
    ++ lsp ++ formatter;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly.packages.${pkgs.system}.default;
  };
}
