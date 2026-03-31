{pkgs, ...}: let
  enable = false;
in {
  services = {
    ollama = {
      inherit enable;
      package = pkgs.ollama-cuda;
    };
    open-webui = {
      inherit enable;
      port = 8080;

      environment = {
        WEBUI_AUTH = "False";
      };
    };
  };
}
