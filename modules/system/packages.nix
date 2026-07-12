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
    devenv
    gcc
    git
    gnumake
    libtool
    nodejs
    vim

    # Kubernetes / Container Tools
    kind
    kubectl

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

    # Media
    imagemagick

    # LaTeX (for org-mode PDF export)
    (texlive.combine {
      inherit (texlive) scheme-medium collection-latexextra;
    })
  ];

  fonts.packages = with pkgs; [
    iosevka-bin
    (iosevka-bin.override { variant = "SS05"; })   # Emacs fixed-pitch font
    (iosevka-bin.override { variant = "Etoile"; }) # Emacs variable-pitch font
  ];
}
