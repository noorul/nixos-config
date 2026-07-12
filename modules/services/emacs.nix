{ config, lib, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    install = true;
  };

  # Keep the running Emacs daemon alive across rebuilds. The unit file is
  # still updated; restart manually with `systemctl --user restart emacs`
  # to pick up a new Emacs version.
  systemd.user.services.emacs.restartIfChanged = false;
}
