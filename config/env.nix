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

      # Point ssh/git at gnome-keyring's gcr-ssh-agent so SSH keys unlock once
      # per session. SDDM-launched mangowc doesn't inherit the systemd user env
      # that gcr-ssh-agent.socket sets, so export it at login here.
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gcr/ssh";

      XDG_DATA_DIRS = ["/var/lib/flatpak/exports/share" "$XDG_DATA_HOME/flatpak/exports/share"];

      TERMINAL = "ghostty";
    };
  };
}
