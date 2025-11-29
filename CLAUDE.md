# CLAUDE.md - AI Assistant Guide for nixos-config

## Repository Overview

This repository contains the NixOS system configuration for a personal PC named **nomshaz**. It uses **Nix flakes** for reproducible system management and is designed to be version-controlled and easily deployable.

### Key Information
- **Hostname**: nomshaz
- **System Type**: Personal desktop/workstation
- **Configuration Style**: Flake-based NixOS
- **Desktop Environment**: GNOME with GDM
- **NixOS Version**: 25.05
- **Timezone**: Asia/Kolkata
- **Locale**: en_IN (English - India)

### Users
- **noorul** - Primary user (Noorul Islam K M) - uses zsh shell
- **unreal** - Secondary user (Mr.Noman)
- **shaz** - Tertiary user (Chachu)

All users are in `networkmanager` and `wheel` groups (admin privileges).

## Repository Structure

### Current State (Minimal Configuration)

```
nixos-config/
├── README.md                    # Basic repository description
└── CLAUDE.md                    # This file - AI assistant guide
```

### Expected Structure (As It Grows)

```
nixos-config/
├── flake.nix                    # Flake entry point (to be created)
├── flake.lock                   # Locked dependency versions (auto-generated)
├── configuration.nix            # Main system configuration (to be migrated)
├── hardware-configuration.nix   # Hardware-specific settings (to be migrated)
├── README.md                    # User-facing documentation
├── CLAUDE.md                    # This file - AI assistant guide
├── hosts/                       # Per-host configurations (future multi-machine)
│   └── nomshaz/
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── modules/                     # Reusable NixOS modules
│   ├── common/                  # Shared settings across machines
│   ├── desktop/                 # Desktop environment configs
│   ├── services/                # Service configurations
│   └── development/             # Development tools and environments
├── home/                        # Home Manager configurations (future)
│   ├── noorul/
│   ├── unreal/
│   └── shaz/
├── overlays/                    # Package overlays (custom builds)
└── packages/                    # Custom package definitions
```

## Current System Configuration

The system currently uses a **monolithic configuration** located at `/etc/nixos/configuration.nix` on the actual system. Key components:

### Boot Configuration
- **Bootloader**: systemd-boot (UEFI)
- **Configuration Limit**: 2 (keeps only 2 generations in boot menu)
- **EFI Variables**: Writable

### Networking
- **Network Manager**: Enabled (GUI network management)
- **Hostname**: nomshaz

### Desktop Environment
- **Display Server**: X11
- **Display Manager**: GDM (GNOME Display Manager)
  - Auto-suspend disabled
- **Desktop**: GNOME
- **Keyboard Layout**: US
- **Caps Lock**: Remapped to Ctrl (`ctrl:nocaps`)

### Audio
- **Sound Server**: PipeWire (replaces PulseAudio)
- **ALSA Support**: Enabled (including 32-bit)
- **PulseAudio Compatibility**: Enabled via PipeWire

### Services
- **Printing**: CUPS enabled
- **SSH**: OpenSSH server enabled
- **Flatpak**: Enabled (for containerized apps)

### Installed System Packages

**Development Tools**:
- gcc, cmake, gnumake, libtool
- git, curl, wget
- emacs30-gtk3, vim
- ripgrep, fd (modern find/grep)

**Terminal & Shell**:
- alacritty (terminal emulator)
- tmux (terminal multiplexer)
- zsh (installed system-wide, noorul's default shell)
- mosh (mobile shell)

**System Utilities**:
- htop (process monitor)
- usbutils
- gnupg
- ispell (spell checker)

**Fonts**:
- iosevka-bin

**Applications**:
- firefox (enabled as program)
- brave (chromium-based browser)

### Nix Configuration
- **Experimental Features**: `nix-command` and `flakes` enabled
- **Unfree Packages**: Allowed (for proprietary software like Brave)

## Development Workflows

### Making Configuration Changes

When modifying the NixOS configuration:

1. **Edit configuration files** in this repository
2. **Test changes locally** (if you have SSH access to the system):
   ```bash
   sudo nixos-rebuild test
   ```
3. **Apply permanently**:
   ```bash
   sudo nixos-rebuild switch
   ```
4. **Commit changes** to git with descriptive messages
5. **Push to remote** repository

### Adding New Packages

**System-wide packages** (available to all users):
```nix
environment.systemPackages = with pkgs; [
  # Add new package here
  package-name
];
```

**Per-user packages** (in user's packages list):
```nix
users.users.username = {
  packages = with pkgs; [
    # User-specific package
  ];
};
```

**Program modules** (for programs with special configuration):
```nix
programs.program-name = {
  enable = true;
  # Additional configuration
};
```

### Adding New Services

Services follow this pattern:
```nix
services.service-name = {
  enable = true;
  # Service-specific configuration
};
```

### Creating Modules

When configuration becomes complex, extract into modules:

```nix
# modules/desktop/gnome.nix
{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # ... other GNOME-specific settings
}
```

Then import in main configuration:
```nix
imports = [
  ./modules/desktop/gnome.nix
];
```

## Migration to Flakes (Planned)

The repository is being transitioned to use flakes. The flake structure will look like:

```nix
# flake.nix
{
  description = "NixOS configuration for nomshaz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # Future: home-manager, etc.
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nomshaz = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # Additional modules
      ];
    };
  };
}
```

After flake migration, rebuild commands become:
```bash
sudo nixos-rebuild switch --flake .#nomshaz
```

## Conventions for AI Assistants

### File Organization

1. **Keep configuration modular**: Split large configuration files into logical modules
2. **Use descriptive names**: Module names should reflect their purpose
3. **Maintain imports**: Always update `imports` when creating new modules
4. **Document changes**: Add comments explaining non-obvious configurations

### Code Style

1. **Indentation**: Use 2 spaces (NixOS convention)
2. **Attribute ordering**: Group related attributes together
3. **Comments**: Add comments for:
   - Non-obvious configurations
   - Hardware-specific settings
   - Workarounds or fixes
   - Security-related decisions

4. **Package lists**: Organize alphabetically within categories:
   ```nix
   environment.systemPackages = with pkgs; [
     # Development
     gcc
     git
     vim

     # System utilities
     htop
     tmux
   ];
   ```

### Making Changes

1. **Read before modifying**: Always read the current configuration before suggesting changes
2. **Preserve user settings**: Don't remove or change existing configurations without explicit request
3. **Test safety**: Prefer `nixos-rebuild test` before `switch` for testing changes
4. **Backup awareness**: NixOS keeps generations, but still commit before major changes
5. **Security considerations**:
   - Never disable the firewall without explicit request
   - Be cautious with SUID programs
   - Document security implications of changes

### Adding Features

When adding new functionality:

1. **Check if module exists**: Many features have dedicated NixOS modules
2. **Use programs.* when available**: Prefer `programs.name.enable` over manual package installation
3. **Enable services properly**: Use `services.* modules` rather than manual service setup
4. **Consider all users**: Determine if changes should be system-wide or per-user
5. **Document dependencies**: Note if a feature requires other services/packages

### Git Workflow

1. **Develop on feature branches**: Use `claude/*` branches for AI assistant work
2. **Commit messages**: Use clear, descriptive messages:
   - `Add package X for feature Y`
   - `Enable service Z for user A`
   - `Refactor: Extract GNOME config to module`
   - `Fix: Resolve audio issue with PipeWire`

3. **Atomic commits**: One logical change per commit
4. **Push regularly**: Push to remote after completing features

### Common Patterns

**Enabling a desktop application**:
```nix
programs.application-name.enable = true;
```

**Adding a development environment**:
```nix
environment.systemPackages = with pkgs; [
  # Language runtime
  python311
  # Build tools
  python311Packages.pip
  # IDE/Editor
  vscode
];
```

**Configuring a service**:
```nix
services.service-name = {
  enable = true;
  port = 8080;
  # Additional options
};
```

**Adding a user**:
```nix
users.users.username = {
  isNormalUser = true;
  description = "Full Name";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.bash;  # or pkgs.zsh
  packages = with pkgs; [ /* user packages */ ];
};
```

## Important Notes

### System State Version
- **Current**: 25.05
- **NEVER change** `system.stateVersion` on existing systems
- This value should only reflect the initial installation version
- Changing it can break system data and services

### Package Management
- **Unfree packages**: Currently allowed via `nixpkgs.config.allowUnfree = true`
- **Search packages**: Use `nix search nixpkgs package-name`
- **Package options**: Check options.nixos.org for service configurations

### Hardware Configuration
- The file `hardware-configuration.nix` is **auto-generated** by NixOS
- Only modify if you understand the hardware implications
- Regenerate with: `sudo nixos-generate-config`

### Bootloader Limit
- Currently set to keep only 2 generations in boot menu
- Older generations still exist but won't show in boot menu
- List all generations: `sudo nix-env --list-generations --profile /nix/var/nix/profiles/system`
- Clean old generations: `sudo nix-collect-garbage --delete-older-than 30d`

## Troubleshooting

### Configuration Syntax Errors
- Validate syntax: `nix eval .#nixosConfigurations.nomshaz.config.system.build.toplevel` (with flakes)
- Or: `sudo nixos-rebuild dry-build` (current system)

### Service Issues
- Check service status: `systemctl status service-name`
- View logs: `journalctl -u service-name`
- Restart service: `sudo systemctl restart service-name`

### Rollback Bad Configuration
```bash
# List generations
sudo nixos-rebuild list-generations

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Or boot into previous generation from boot menu
```

## Resources

- **NixOS Manual**: https://nixos.org/manual/nixos/stable/
- **NixOS Options Search**: https://search.nixos.org/options
- **Nix Package Search**: https://search.nixos.org/packages
- **Home Manager Manual**: https://nix-community.github.io/home-manager/
- **Nix Pills**: https://nixos.org/guides/nix-pills/ (learning resource)

## Future Enhancements

Consider adding as the configuration grows:

1. **Home Manager**: Per-user dotfile and application management
2. **Secrets Management**: Using sops-nix or agenix for sensitive data
3. **Multiple Hosts**: Shared modules across multiple machines
4. **Custom Overlays**: Modified or custom package builds
5. **Development Shells**: Per-project development environments with `shell.nix`
6. **Automated Backups**: Using NixOS backup modules
7. **Declarative Containers**: Docker or systemd-nspawn containers
8. **Remote Deployment**: Using deploy-rs or colmena

## Contact & Maintenance

- **Primary Maintainer**: Noorul Islam K M (noorul@noorul.com)
- **Repository**: This is a personal configuration repository
- **Updates**: Regularly update flake inputs to get security patches and new packages

---

**Last Updated**: 2025-11-29
**NixOS Version**: 25.05
**Configuration Status**: Minimal monolithic configuration, preparing for flake migration
