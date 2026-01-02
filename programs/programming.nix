{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    webhook
  ];
}
