{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "shaz";
  home.homeDirectory = "/home/shaz";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Enable XDG directory management
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  # User-specific packages
  home.packages = with pkgs; [
    # Add user-specific packages here
  ];

  # Basic program configurations
  programs.git = {
    enable = true;
    userName = "Chachu";
    userEmail = "shaz@example.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
