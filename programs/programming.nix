{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    webhook
    claude-code
  ];
}
