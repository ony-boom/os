## Might not empty one day
{pkgs, ...}: let
  lua = with pkgs; [
    lua51Packages.lua
    lua51Packages.luarocks
  ];
in {
  environment.systemPackages = lua ++ [];
}
