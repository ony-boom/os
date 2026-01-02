{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
    open-webui = {
      enable = false;
      port = 8080;

      environment = {
        WEBUI_AUTH = "False";
      };
    };
  };
}
