{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
    open-webui = {
      enable = true;
      port = 8080;

      environment = {
        WEBUI_AUTH = "False";
      };
    };
  };
}
