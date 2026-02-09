# Linux Dynamic Wallpapers for NixOS

A Nix package providing 109+ professional dynamic wallpapers for GNOME with time-based transitions. This is a complete port of the [saint-13/Linux_Dynamic_Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers) repository for NixOS and Home Manager.

## Features

- **109+ Dynamic Wallpapers** with smooth time-based transitions
- **More than just light/dark**: Multiple images throughout the 24-hour cycle
- **Full GNOME integration**: Appears in Settings → Appearance → Background
- **Declarative configuration**: Pure NixOS/Home Manager setup
- **Zero manual installation**: No scripts or manual file copying

## Gallery

The collection includes wallpapers in various categories:

- **macOS Inspired**: BigSur (8 time-of-day variants), Monterey, Mojave, Catalina
- **Nature**: Mountains, Desert, Forest, Lakeside, Ocean
- **Abstract**: Aura, Blobs, Material Design, Nord Theme
- **Lofi/Anime**: LofiGirl, AnimeRoom, CatherineRoom
- **OS Themes**: Ubuntu, Windows 11, Elementary OS, GNOME 42
- **Gaming**: Firewatch, Witcher, Cyberpunk
- ...and 80+ more!

## Installation

### Method 1: Using Flakes (Recommended)

Add this flake as an input to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    linux-dynamic-wallpapers.url = "github:YOUR_USERNAME/linux-dynamic-wallpapers-nix";
    # Or use a local path during development:
    # linux-dynamic-wallpapers.url = "path:/etc/nixos/pkgs/linux-dynamic-wallpapers";
  };

  outputs = { self, nixpkgs, home-manager, linux-dynamic-wallpapers, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.users.your-username = {
            imports = [
              linux-dynamic-wallpapers.homeManagerModules.default
            ];

            programs.linux-dynamic-wallpapers.enable = true;
          };
        }
      ];
    };
  };
}
```

### Method 2: As an Overlay

```nix
{
  nixpkgs.overlays = [
    linux-dynamic-wallpapers.overlays.default
  ];

  home.packages = [ pkgs.linux-dynamic-wallpapers ];
}
```

### Method 3: Standalone Home Manager

```nix
{
  imports = [
    linux-dynamic-wallpapers.homeManagerModules.default
  ];

  programs.linux-dynamic-wallpapers.enable = true;
}
```

## Configuration Options

### Basic Usage

```nix
programs.linux-dynamic-wallpapers = {
  enable = true;
};
```

### Set a Default Wallpaper

```nix
programs.linux-dynamic-wallpapers = {
  enable = true;
  defaultWallpaper = "BigSur";  # Name without .xml extension
};
```

### Handle Existing Files

If you have existing dynamic wallpapers installed, you can force overwrite them:

```nix
programs.linux-dynamic-wallpapers = {
  enable = true;
  forceOverwrite = true;  # Overwrites conflicting files
};
```

**Note**: Without `forceOverwrite = true`, the activation will fail if conflicting files exist. This is a safety feature to prevent accidental data loss.

## Available Wallpapers

<details>
<summary>Click to expand the full list of 109 wallpapers</summary>

- Adwaita
- AnimeRoomBoard
- Aura
- BigSur
- BigSurV2
- Blobs
- Carvan
- Catalina
- ChromeOSBlues
- ClashOfClans
- Cloudy
- Cyberpunk
- Desert
- DessertPeak
- Elementary
- Firewatch
- Forest
- GNOME42
- Globe
- Island
- Lakeside
- LofiGirl
- Material
- Mojave
- Monterey
- Mountains
- Nord
- Ocean
- Ubuntu
- Windows11
- Witcher
- ...and 78 more!

</details>

See the full list by running:
```bash
ls ~/.local/share/backgrounds/Dynamic_Wallpapers/
```

## Usage After Installation

1. Log out and log back in (or restart GNOME: `Alt+F2` → `r`)
2. Open **Settings** → **Appearance** → **Background**
3. Scroll through the wallpaper selection
4. Select any dynamic wallpaper - it will automatically change based on time of day!

## How Do Time-Based Wallpapers Work?

Dynamic wallpapers use GNOME's XML format with two elements:

- `<static>`: Displays an image for X seconds
- `<transition>`: Smooth transition between two images over Y seconds

**Example (BigSur)**:
```
00:00 - 04:00 → Night (Image 8)
04:00 - 07:00 → Transition to sunrise
07:00 - 08:45 → Morning (Image 5)
08:45 - 10:30 → Transition to midday
10:30 - 11:15 → Midday (Image 4)
...continues through 8 different images over 24 hours
```

## Comparison with Other Packages

### `dynamic-wallpaper` (nixpkgs)
- **Tool** for creating your own dynamic wallpapers
- No pre-made wallpapers included

### `linux-dynamic-wallpapers` (this package)
- **Library** of 109+ professional wallpapers
- Ready to use immediately
- Complex multi-image time cycles

## Troubleshooting

### Wallpapers don't appear in Settings

1. Ensure you ran `nixos-rebuild switch` or `home-manager switch`
2. Log out and log back in (GNOME needs to restart)
3. Check that Home Manager is properly configured

### Test Installation

```bash
# Check if wallpapers are installed
ls ~/.local/share/backgrounds/Dynamic_Wallpapers/

# Check GNOME properties
ls ~/.local/share/gnome-background-properties/
```

### Wallpaper doesn't change

- Verify your system time is correct
- GNOME uses the XML definitions for timing
- Changes are often subtle (smooth transitions)

### Conflict with Existing Files

If you get an error about existing files being "clobbered":

**Option 1**: Enable force overwrite
```nix
programs.linux-dynamic-wallpapers.forceOverwrite = true;
```

**Option 2**: Manually backup and remove old files
```bash
mkdir -p ~/.local/share/gnome-background-properties-backup
mv ~/.local/share/gnome-background-properties/*.xml ~/.local/share/gnome-background-properties-backup/
```

## Development

### Local Development

To use a local checkout of the wallpapers:

```nix
# In default.nix, replace the src with:
src = /path/to/Linux_Dynamic_Wallpapers;
# Note: Requires --impure flag when building
```

### Testing Changes

```bash
# Test build
nix build .#linux-dynamic-wallpapers

# Test Home Manager module
home-manager switch --flake .#your-config
```

## Contributing

Contributions are welcome! To add new wallpapers or improve the package:

1. Fork the upstream repository: https://github.com/saint-13/Linux_Dynamic_Wallpapers
2. Add your wallpapers there (follow their contribution guidelines)
3. Submit a PR to update the `rev` and `sha256` in this package

## Credits

- **Original Wallpapers**: [saint-13/Linux_Dynamic_Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers)
- **NixOS Package**: Created for the NixOS community
- **License**: GPL-3.0+ (same as upstream)

## Resources

- [Original Repository](https://github.com/saint-13/Linux_Dynamic_Wallpapers)
- [GNOME Wallpaper Documentation](https://help.gnome.org/admin/system-admin-guide/stable/backgrounds.html)
- [NixOS Wiki](https://nixos.wiki/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)

## License

GPL-3.0-or-later

This package redistributes content from the Linux_Dynamic_Wallpapers repository, which is licensed under GPL-3.0+.
