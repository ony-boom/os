{stable-pkgs, ...}: {
  environment.systemPackages = with stable-pkgs; [
    ardour
  ];
}
