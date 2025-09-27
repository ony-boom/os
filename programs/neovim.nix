{pkgs, inputs, ...}: let 
 lsp = with pkgs; [
    typescript-language-server
    vscode-langservers-extracted
    lua-language-server
 ];

 formatter = with pkgs; [
    stylua
    biome
    alejandra
    prettierd
 ];
in {
  environment.systemPackages = with pkgs; [
    gcc
    tree-sitter
  ] ++ lsp ++ formatter;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly.packages.${pkgs.system}.default;
  };
}
