{
  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      XDG_CONFIG_HOME = "$HOME/.config";
      ZDOTDIR = "$XDG_CONFIG_HOME/zsh";

      XDG_DATA_DIRS = ["/var/lib/flatpak/exports/share" "$XDG_DATA_HOME/flatpak/exports/share"];

      TERMINAL = "ghostty";
      BROWSER = "google-chrome";
    };
  };
}
