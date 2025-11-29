{ config, lib, pkgs, ... }:

{
  # Nix configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}