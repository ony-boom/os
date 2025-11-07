{
  pkgs,
  inputs,
  ...
}: let
  lsp = with pkgs; [
    gopls

    nil
    nixd

    biome
    lua-language-server

    svelte-language-server
    astro-language-server
    emmet-language-server
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted

    angular-language-server
    python313Packages.python-lsp-server
  ];

  formatter = with pkgs; [
    gofumpt
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
