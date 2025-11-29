{ config, lib, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nomshaz";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Firewall configuration (currently using defaults)
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether:
  # networking.firewall.enable = false;
}