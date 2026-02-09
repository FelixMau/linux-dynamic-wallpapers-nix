# Linux Dynamic Wallpapers for NixOS

Ein Nix-Paket für die komplette [Linux Dynamic Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers) Sammlung mit 109+ dynamischen Wallpapers für GNOME.

## Features

- **109+ dynamische Wallpapers** mit zeitbasierten Übergängen
- **Nicht nur hell/dunkel**: Mehrere Bilder pro Tag mit sanften Übergängen
- **Vielfältige Kategorien**: Natur, Abstract, Apple-Designs, Anime, und mehr
- **GNOME-Integration**: Erscheint automatisch in den GNOME-Hintergrundeinstellungen
- **NixOS/Home Manager freundlich**: Deklarative Konfiguration

## Installation

### Option 1: Direkt in home.nix

Füge das Paket zu deinen Home Manager Paketen hinzu:

```nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    linux-dynamic-wallpapers
  ];

  # Verlinke Wallpapers in dein Home-Verzeichnis
  xdg.dataFile = {
    "backgrounds/Dynamic_Wallpapers" = {
      source = "${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers";
      recursive = true;
    };
    "gnome-background-properties" = {
      source = "${pkgs.linux-dynamic-wallpapers}/share/gnome-background-properties";
      recursive = true;
    };
  };
}
```

### Option 2: Mit Home Manager Modul (vereinfacht)

Importiere das mitgelieferte Modul in deine home.nix:

```nix
{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/pkgs/linux-dynamic-wallpapers/home-manager-module.nix
  ];

  programs.linux-dynamic-wallpapers.enable = true;
}
```

## Verwendung

Nach der Installation und einem `nixos-rebuild switch`:

1. Öffne **GNOME Settings** → **Appearance** → **Background**
2. Die dynamischen Wallpapers erscheinen in der Wallpaper-Auswahl
3. Wähle einen Wallpaper aus - er ändert sich automatisch basierend auf der Tageszeit

## Verfügbare Wallpapers (Auswahl)

- **Apple-Designs**: BigSur, Monterey, Mojave, Catalina
- **Natur**: Mountains, Desert, Forest, Lake, Ocean
- **Abstract**: Aura, Globe, Material, Blobs
- **Lofi/Anime**: AnimeRoom, LofiGirl, verschiedene Stile
- **OS-Themes**: Ubuntu, Windows 11, Elementary OS, GNOME 42
- Und viele mehr...

## Technische Details

### Wie funktionieren die dynamischen Wallpapers?

Die Wallpapers verwenden GNOME's XML-basiertes Format für zeitbasierte Hintergründe:

- `<static>`: Zeigt ein Bild für eine bestimmte Dauer (in Sekunden)
- `<transition>`: Sanfter Übergang zwischen zwei Bildern über eine Zeitspanne

Beispiel (BigSur hat 8 verschiedene Bilder über den Tag verteilt):
- 4 Stunden Nachtbild → 3h Übergang → Morgengrauen → ...

### Unterschied zum existierenden `dynamic-wallpaper` Paket

Das existierende nixpkgs `dynamic-wallpaper` Paket ist ein **Tool zum Erstellen** von dynamischen Wallpapers.

Dieses Paket (`linux-dynamic-wallpapers`) ist:
- Eine fertige **Bibliothek von 109+ professionellen Wallpapers**
- Sofort nutzbar ohne eigene Erstellung
- Mit komplexen Multi-Bild-Animationen (nicht nur hell/dunkel)

## Lokale Entwicklung

Falls du das lokale Repository für Tests verwenden möchtest:

```nix
# In pkgs/linux-dynamic-wallpapers/default.nix
src = /home/felix/Linux_Dynamic_Wallpapers;  # Statt fetchFromGitHub
```

## Hash aktualisieren

Beim ersten Build wird Nix den korrekten Hash anzeigen:

```bash
sudo nixos-rebuild build --flake .#Desktop
# Kopiere den angezeigten Hash in default.nix
```

## Lizenz

Die Original-Wallpapers sind GPL-3.0+ lizenziert.
Siehe: https://github.com/saint-13/Linux_Dynamic_Wallpapers

## Credits

- Original-Repository: [saint-13/Linux_Dynamic_Wallpapers](https://github.com/saint-13/Linux_Dynamic_Wallpapers)
- Nix-Paket erstellt für die NixOS-Community
