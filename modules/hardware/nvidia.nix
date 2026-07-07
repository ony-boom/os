# Opt-in NVIDIA GPU module. Hosts with an NVIDIA card import this from their
# hosts/<name>/default.nix; hosts on Intel/AMD simply don't.
{pkgs, ...}: {
  # NVIDIA's VA-API/NVDEC decode is broken under Chrome's native Wayland
  # backend (vaEndPicture "internal decoding error" -> CPU-bound software
  # decode on 1080p+ video). Forcing the X11/XWayland path restores working
  # GPU decode. Applied as an overlay so the shared package list stays generic
  # and non-NVIDIA hosts get a stock Chrome.
  nixpkgs.overlays = [
    (_: prev: {
      google-chrome = prev.google-chrome.override {
        commandLineArgs = ["--ozone-platform=x11"];
      };
    })
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = true;

  # libva-utils gives `vainfo` for verifying VA-API works
  environment.systemPackages = [pkgs.libva-utils];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    # The default EGL backend is broken on driver 525+; the direct backend
    # is required for VA-API to actually work on current drivers.
    NVD_BACKEND = "direct";
  };

  # GPU backend hints for the Wayland session. These live here (not in the WM
  # module) so the desktop stack stays GPU-agnostic across hosts.
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };
}
