{ config, lib, pkgs, ... }:

{
  # NVIDIA graphics driver configuration.
  # Using the open kernel modules (Turing GPUs and newer).
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
  };

  # Wayland + NVIDIA glue: makes GBM, GLX, and VA-API prefer the NVIDIA
  # driver, which fixes rendering artifacts in GPU-accelerated apps
  # (Ghostty, vterm under pgtk Emacs, Chromium/Electron).
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
}
