{ config, lib, pkgs, ... }:

{
  # System packages installed in system profile
  # To search for packages, run: nix search nixpkgs <package-name>
  environment.systemPackages = with pkgs; [
    # Terminal & Shell
    alacritty
    ghostty
    tmux
    mosh

    # Development Tools
    cmake
    gcc
    git
    gnumake
    libtool
    nodejs
    vim

    # System Utilities
    curl
    fd
    gnupg
    htop
    ispell
    ripgrep
    usbutils
    wget

    # Applications
    brave
    google-chrome
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
    (iosevka-bin.override { variant = "SS05"; })   # Emacs fixed-pitch font
    (iosevka-bin.override { variant = "Etoile"; }) # Emacs variable-pitch font
  ];
}
