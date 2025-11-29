{ config, lib, pkgs, ... }:

{
  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable Flatpak for containerized applications
  services.flatpak.enable = true;
}