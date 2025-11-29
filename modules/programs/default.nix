{ config, lib, pkgs, ... }:

{
  # Program configurations

  # Install Firefox
  programs.firefox.enable = true;

  # Install and enable zsh
  programs.zsh = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}