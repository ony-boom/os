{config, ...}: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = true;
    
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
