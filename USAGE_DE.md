# Verwendungsanleitung - Linux Dynamic Wallpapers für NixOS

## Schnellstart

### 1. Paket ist bereits in flake.nix integriert ✓

Das Paket ist durch das Overlay in deiner `flake.nix` bereits verfügbar.

### 2. In home.nix aktivieren

Öffne deine `home/home.nix` und füge hinzu:

```nix
{ config, pkgs, machine, mistral-vibe-pkg, ... }:

{
  # ... deine bestehende Konfiguration ...

  # Aktiviere Dynamic Wallpapers
  imports = [
    ../pkgs/linux-dynamic-wallpapers/home-manager-module.nix
  ];

  programs.linux-dynamic-wallpapers.enable = true;

  # ... rest deiner Konfiguration ...
}
```

### 3. System neu bauen

```bash
sudo nixos-rebuild switch --flake .#Desktop
# oder für Laptop:
sudo nixos-rebuild switch --flake .#Laptop
```

### 4. Wallpaper auswählen

Nach dem Neustart:

1. Öffne **Einstellungen** → **Erscheinungsbild** → **Hintergrund**
2. Scrolle durch die verfügbaren Wallpapers
3. Wähle einen dynamischen Wallpaper aus

Die Wallpapers ändern sich automatisch basierend auf der Tageszeit!

## Verfügbare Wallpapers

Das Paket enthält **109 dynamische Wallpapers**:

### Natur & Landschaften
- **BigSur** - macOS Big Sur Berge (8 Tageszeiten)
- **Monterey** - macOS Monterey Ozeanwellen
- **Mojave** - macOS Mojave Wüstenlandschaft
- **Catalina** - macOS Catalina Insel
- **Lakeside** - Friedlicher Bergsee
- **Mountains** - Epische Bergkette
- **Desert** - Wüstenlandschaft
- **Forest** - Dichter Wald

### Abstract & Modern
- **Aura** - Farbverläufe und Aura-Effekte
- **Blobs** - Moderne abstrakte Formen
- **Material** - Material Design inspiriert
- **Nord** - Nord Theme Farbschema
- **Globe** - Rotierender Globus

### Lofi & Anime
- **LofiGirl** - Klassisches Lofi-Zimmer
- **AnimeRoom** - Gemütliches Anime-Zimmer
- **CatherineRoom** - Detailliertes Zimmer-Design

### OS Themes
- **Ubuntu** - Ubuntu-inspirierte Designs
- **Windows11** - Windows 11 Style
- **Elementary** - Elementary OS Design
- **GNOME42** - GNOME 42 Official

### Gaming & Pop Culture
- **Firewatch** - Firewatch-inspirierte Landschaft
- **Witcher** - The Witcher inspiriert
- **Cyberpunk** - Cyberpunk-Ästhetik

...und 80+ weitere!

## Erweiterte Konfiguration

### Standard-Wallpaper setzen

Falls du einen Wallpaper automatisch als Standard setzen möchtest:

```nix
{ config, pkgs, ... }:

{
  programs.linux-dynamic-wallpapers.enable = true;

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers/BigSur.xml";
      picture-uri-dark = "file://${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers/BigSur.xml";
      picture-options = "zoom";  # oder "stretched", "centered", "scaled", "spanned"
    };
  };
}
```

### Nur bestimmte Wallpapers installieren

Falls du nicht alle 109 Wallpapers möchtest, kannst du das Paket anpassen:

```nix
# Erstelle eine custom Version in pkgs/linux-dynamic-wallpapers/minimal.nix
{ pkgs }:

pkgs.linux-dynamic-wallpapers.overrideAttrs (old: {
  installPhase = ''
    # ... (kopiere nur spezifische Wallpapers)
  '';
})
```

## Wie funktionieren zeitbasierte Wallpapers?

Die dynamischen Wallpapers verwenden GNOME's XML-Format:

- **`<static>`**: Zeigt ein Bild für X Sekunden
- **`<transition>`**: Sanfter Übergang zwischen zwei Bildern über Y Sekunden

Beispiel BigSur:
```
00:00 - 04:00 → Nacht (Bild 8)
04:00 - 07:00 → Übergang zu Sonnenaufgang
07:00 - 08:45 → Morgen (Bild 5)
08:45 - 10:30 → Übergang zu Mittag
10:30 - 11:15 → Mittag (Bild 4)
... usw.
```

Insgesamt durchläuft BigSur 8 verschiedene Bilder über 24 Stunden!

## Unterschied zu existierenden Paketen

### `dynamic-wallpaper` (nixpkgs)
- Tool zum **Erstellen** eigener dynamischer Wallpapers
- Keine vorgefertigten Wallpapers

### `linux-dynamic-wallpapers` (dieses Paket)
- Fertige **Bibliothek** von 109+ professionellen Wallpapers
- Sofort einsatzbereit
- Komplexe Multi-Bild-Zyklen

## Fehlerbehebung

### Wallpapers erscheinen nicht in den Einstellungen

Stelle sicher, dass:
1. Du `nixos-rebuild switch` ausgeführt hast
2. Du GNOME neu gestartet hast (Log out/in)
3. Home Manager korrekt aktiviert ist

### Pfade testen

```bash
# Prüfe ob das Paket installiert ist
ls ~/.local/share/backgrounds/Dynamic_Wallpapers/

# Prüfe GNOME Properties
ls ~/.local/share/gnome-background-properties/
```

### Wallpaper ändert sich nicht

- Stelle sicher, dass die Systemzeit korrekt ist
- GNOME verwendet die XML-Definitionen für Timing
- Die Änderungen sind oft subtil (sanfte Übergänge)

## Wallpaper von GitHub statt lokal verwenden

Wenn du möchtest, dass das Paket direkt von GitHub lädt statt vom lokalen Verzeichnis:

1. Öffne `/etc/nixos/pkgs/linux-dynamic-wallpapers/default.nix`
2. Kommentiere die lokale Quelle aus und aktiviere GitHub:

```nix
# src = /home/felix/Linux_Dynamic_Wallpapers;

src = fetchFromGitHub {
  owner = "saint-13";
  repo = "Linux_Dynamic_Wallpapers";
  rev = "45128514ae51c6647ab3e427dda2de40c74a40e5";
  sha256 = "...";  # Hash wird beim ersten Build angezeigt
};
```

3. Führe einen Build aus, um den korrekten Hash zu erhalten:

```bash
sudo nixos-rebuild build --flake .#Desktop
# Kopiere den angezeigten Hash in default.nix
```

## Beitragen

Falls du neue Wallpapers hinzufügen oder das Paket verbessern möchtest:

1. Fork das Original-Repository: https://github.com/saint-13/Linux_Dynamic_Wallpapers
2. Erstelle Pull Requests dort
3. Update den `rev` und `sha256` in diesem Paket

## Ressourcen

- Original-Repository: https://github.com/saint-13/Linux_Dynamic_Wallpapers
- GNOME Wallpaper-Format: https://help.gnome.org/admin/system-admin-guide/stable/backgrounds.html
- NixOS Wiki: https://nixos.wiki/

## Lizenz

GPL-3.0+ (wie das Original-Repository)
