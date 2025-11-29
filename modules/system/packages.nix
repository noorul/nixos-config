{ config, lib, pkgs, ... }:

{
  # System packages installed in system profile
  # To search for packages, run: nix search nixpkgs <package-name>
  environment.systemPackages = with pkgs; [
    # Terminal & Shell
    alacritty
    tmux
    mosh

    # Development Tools
    cmake
    gcc
    git
    gnumake
    libtool
    emacs30-gtk3
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

    # Fonts
    iosevka-bin
  ];
}