{pkgs, ...}: {
  systemd.services.vicinae = {
    description = "Vicinae server";
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = 5;
      KillMode = "process";
      ExecStart = "${pkgs.vicinae}/bin/vicinae server";
    };
  };
}
