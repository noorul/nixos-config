{ config, lib, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    install = true;
  };
}
