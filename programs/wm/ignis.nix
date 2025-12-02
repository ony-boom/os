{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    (inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      enableAudioService = true;
      useDartSass = true;
      extraPackages = [
      ];
    })
  ];
}
