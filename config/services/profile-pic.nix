{
  systemd.services."sddm-avatar" = {
    description = "Service to copy or update users Avatars at startup.";
    wantedBy = ["multi-user.target"];
    before = ["sddm.service"];
    script = ''
      username="ony"
      userhome="/home/$username"
      target="/var/lib/AccountsService/icons/$username"
      if [ -f "$userhome/.face.icon" ]; then
        cp "$userhome/.face.icon" "$target"
      fi
    '';
    serviceConfig = {
      Type = "simple";
      User = "root";
    };
  };
  systemd.services.sddm = {
    after = ["sddm-avatar.service"];
  };
}
