{pkgs, ...}: let
  enable = true;
in {
  services = {
    ollama = {
      inherit enable;
      package = pkgs.ollama-cuda;
    };
  };
}
