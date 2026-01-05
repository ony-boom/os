{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    webhook
    watchman # android dev thing
  ];
}
