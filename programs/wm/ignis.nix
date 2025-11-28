{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    (inputs.ignis.packages.${pkgs.system}.default.override {
      enableAudioService = true;
      useDartSass = true;
      extraPackages = [
      ];
    })
  ];
}
