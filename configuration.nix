# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # User accounts
      ./modules/users

      # Desktop environment
      ./modules/desktop/gnome.nix
      ./modules/desktop/audio.nix

      # System configuration
      ./modules/system/boot.nix
      ./modules/system/nix.nix
      ./modules/system/packages.nix
      ./modules/system/locale.nix

      # Services
      ./modules/services/networking.nix
      ./modules/services/desktop-apps.nix

      # Programs
      ./modules/programs
    ];

  # All system configuration has been moved to modules/

  # User accounts are defined in modules/users/default.nix
  # User-specific packages and configurations are managed by Home Manager in home/<username>/

  # Programs, services, and packages are configured in respective modules/

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
