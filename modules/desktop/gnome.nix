{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.autoSuspend = false;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };

  # Enable touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # Workaround for NVIDIA + GNOME Wayland: after DPMS or screen lock,
  # Mutter fails to repaint text (empty password/search fields, scrambled
  # tiles). Disable auto screen-blank and lock until the driver bug is
  # fixed upstream.
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.desktop.session]
    idle-delay=uint32 0

    [org.gnome.desktop.screensaver]
    lock-enabled=false

    [org.gnome.settings-daemon.plugins.power]
    sleep-inactive-ac-type='nothing'
    sleep-inactive-battery-type='nothing'
  '';

  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = [
    pkgs.gsettings-desktop-schemas
    pkgs.gnome-settings-daemon
  ];
}