## Might not empty one day
{pkgs, ...}: let
  lua = with pkgs; [
    lua51Packages.lua
    lua51Packages.luarocks
  ];
in {
  environment.systemPackages =
    lua
    ++ (with pkgs; [
      # Shared across hosts: the toolbox is the launcher for every JetBrains IDE,
      # so it belongs to the base rather than to one machine.
      jetbrains-toolbox
    ]);
}
