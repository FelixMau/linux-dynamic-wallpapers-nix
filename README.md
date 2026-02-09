# Linux Dynamic Wallpapers for NixOS 🌄

A NixOS/Home Manager package providing **109+ professional dynamic wallpapers** for GNOME with time-based transitions.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Nix](https://img.shields.io/badge/Built%20with-Nix-5277C3.svg?logo=nixos)](https://nixos.org)

> This is a complete NixOS/Home Manager port of [saint-13/Linux_Dynamic_Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers) - bringing macOS-style time-based wallpapers to Linux.

## ✨ Features

- 🎨 **109+ Dynamic Wallpapers** with smooth time-based transitions
- ⏰ **More than just light/dark** - Multiple images throughout the 24-hour cycle
- 🖼️ **Full GNOME integration** - Appears directly in Settings → Appearance
- 📦 **Declarative configuration** - Pure NixOS/Home Manager setup
- 🚀 **Zero manual installation** - No scripts, just Nix

## 🖼️ Gallery

The collection includes wallpapers in various categories:

| Category | Examples |
|----------|----------|
| **macOS Inspired** | BigSur (8 variants), Monterey, Mojave, Catalina |
| **Nature** | Mountains, Desert, Forest, Lakeside, Ocean |
| **Abstract** | Aura, Blobs, Material Design, Nord Theme |
| **Lofi/Anime** | LofiGirl, AnimeRoom, CatherineRoom |
| **OS Themes** | Ubuntu, Windows 11, Elementary, GNOME 42 |
| **Gaming** | Firewatch, Witcher, Cyberpunk |

![BigSur Example](https://raw.githubusercontent.com/saint-13/Linux_Dynamic_Wallpapers/main/Screenshots/BigSur.png)

*Example: BigSur wallpaper transitioning through 8 different time-of-day variants*

## 🚀 Quick Start

### Using Flakes (Recommended)

1. Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    linux-dynamic-wallpapers.url = "github:YOUR_USERNAME/linux-dynamic-wallpapers-nix";
  };

  outputs = { nixpkgs, home-manager, linux-dynamic-wallpapers, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.users.your-username = {
            imports = [ linux-dynamic-wallpapers.homeManagerModules.default ];
            programs.linux-dynamic-wallpapers.enable = true;
          };
        }
      ];
    };
  };
}
```

2. Rebuild and enjoy:

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

3. Select wallpapers in **Settings → Appearance → Background**

## 📖 Documentation

- [Quick Start Guide](./README_COMMUNITY.md) - Detailed installation instructions
- [German Documentation](./USAGE_DE.md) - Deutsche Dokumentation
- [Configuration Examples](./example-home.nix) - Sample configurations

## ⚙️ Configuration

### Basic Usage

```nix
programs.linux-dynamic-wallpapers.enable = true;
```

### Set a Default Wallpaper

```nix
programs.linux-dynamic-wallpapers = {
  enable = true;
  defaultWallpaper = "BigSur";
};
```

### Handle Existing Files

```nix
programs.linux-dynamic-wallpapers = {
  enable = true;
  forceOverwrite = true;  # Overwrites conflicting files
};
```

## 🎯 How It Works

Dynamic wallpapers use GNOME's XML format with timed transitions:

```
BigSur Example (24-hour cycle):
00:00 - 04:00 → Night scene
04:00 - 07:00 → Smooth transition to sunrise
07:00 - 10:30 → Morning scene
10:30 - 14:00 → Midday scene
...continues through 8 different images
```

## 🆚 Comparison

| Package | Type | Content |
|---------|------|---------|
| `dynamic-wallpaper` (nixpkgs) | Tool | Create your own wallpapers |
| `linux-dynamic-wallpapers` (this) | Library | 109+ ready-to-use wallpapers |

## 🛠️ Development

### Local Testing

```bash
# Build the package
nix build .#linux-dynamic-wallpapers

# Test with home-manager
home-manager switch --flake .#your-config
```

### Using Local Wallpapers

Edit `default.nix`:
```nix
src = /path/to/Linux_Dynamic_Wallpapers;  # Requires --impure
```

## 🤝 Contributing

Contributions welcome! Please:

1. For new wallpapers: Contribute to [upstream repository](https://github.com/saint-13/Linux_Dynamic_Wallpapers)
2. For package improvements: Open an issue/PR here
3. For bugs: File an issue with your NixOS version

## 📜 License

GPL-3.0-or-later

This package redistributes content from [Linux_Dynamic_Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers), licensed under GPL-3.0+.

## 🙏 Credits

- **Wallpapers**: [saint-13/Linux_Dynamic_Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers)
- **NixOS Package**: Created for the NixOS community
- **Contributors**: See [CONTRIBUTORS](./CONTRIBUTORS) (if you create one)

## 📚 Resources

- [Original Repository](https://github.com/saint-13/Linux_Dynamic_Wallpapers)
- [GNOME Wallpaper Docs](https://help.gnome.org/admin/system-admin-guide/stable/backgrounds.html)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)

---

**Enjoy beautiful time-based wallpapers on NixOS!** 🎉
