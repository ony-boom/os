{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  # libva-utils gives `vainfo` for verifying VA-API works
  environment.systemPackages = [pkgs.libva-utils];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    # The default EGL backend is broken on driver 525+; the direct backend
    # is required for VA-API to actually work on current drivers.
    NVD_BACKEND = "direct";
    # Firefox/Zen decode in the sandboxed RDD process; it needs the sandbox
    # relaxed to reach the NVIDIA decoder.
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };
}
