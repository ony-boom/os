{
  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";

      XDG_DATA_DIRS = ["/var/lib/flatpak/exports/share" "$XDG_DATA_HOME/flatpak/exports/share"];
    };

    variables = {
      TERMINAL = "ghostty";
    };
  };
}
