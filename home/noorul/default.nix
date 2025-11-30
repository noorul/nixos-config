{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "noorul";
  home.homeDirectory = "/home/noorul";

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
    claude-code
    ledger
  ];

  # Program configurations
  programs.git = {
    enable = true;
    userName = "Noorul Islam K M";
    userEmail = "noorul@noorul.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      github = { user = "noorul"; };
    };
    ignores =
      [
        ".projectile"
        ".dir-locals.el"
      ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      update = "sudo nixos-rebuild switch --flake ${config.xdg.configHome}/nixos#nomshaz";
      nixconf = "cd ${config.xdg.configHome}/nixos";
    };

    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    extraConfig = ''
      # Set prefix to Ctrl+a
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Reload config file
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.95;
      };
      font = {
        normal = {
          family = "Iosevka";
          style = "Regular";
        };
        size = 12.0;
      };
      colors = {
        primary = {
          background = "#1e1e1e";
          foreground = "#d4d4d4";
        };
      };
    };
  };

  # Git configuration for development
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  # Starship
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.settings = { command_timeout = 1800000; };

  # bat
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";

  # fzf
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  # eza
  programs.eza.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
