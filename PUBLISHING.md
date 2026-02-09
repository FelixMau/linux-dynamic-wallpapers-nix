# Publishing Guide - Linux Dynamic Wallpapers for NixOS

Anleitung, um dieses Paket für die Community verfügbar zu machen.

## Option 1: GitHub Repository (Empfohlen)

### Schritt 1: GitHub Repository erstellen

1. Gehe zu https://github.com/new
2. Erstelle ein neues Repository, z.B. `linux-dynamic-wallpapers-nix`
3. Setze es auf "Public"
4. **NICHT** "Initialize with README" aktivieren (wir haben schon eine)

### Schritt 2: Lokales Repository vorbereiten

```bash
cd /etc/nixos/pkgs/linux-dynamic-wallpapers

# Wenn noch nicht initialisiert:
git init

# Alle Dateien hinzufügen
git add .

# Ersten Commit erstellen
git commit -m "Initial commit: Linux Dynamic Wallpapers for NixOS

- 109+ dynamic wallpapers with time-based transitions
- Home Manager module with forceOverwrite option
- NixOS module for system-wide installation
- Full GNOME integration
- Standalone flake for easy consumption"
```

### Schritt 3: Zu GitHub pushen

```bash
# Remote hinzufügen (ersetze YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/linux-dynamic-wallpapers-nix.git

# Branch umbenennen zu main (falls nötig)
git branch -M main

# Pushen
git push -u origin main
```

### Schritt 4: README in GitHub anpassen

Bearbeite `README.md` auf GitHub:
- Ersetze `github:YOUR_USERNAME/linux-dynamic-wallpapers-nix` mit deinem echten Username
- Füge Screenshots hinzu (optional, aber empfohlen)
- Erstelle ein "Releases" Tag für Versionierung

### Schritt 5: Erste Release erstellen

```bash
# Tag erstellen
git tag -a v1.0.0 -m "Release v1.0.0

Initial release featuring:
- 109+ dynamic wallpapers
- Home Manager module
- NixOS system module
- Full documentation"

# Tag pushen
git push origin v1.0.0
```

Dann auf GitHub:
1. Gehe zu "Releases" → "Create a new release"
2. Wähle den Tag `v1.0.0`
3. Title: `v1.0.0 - Initial Release`
4. Beschreibung: Kopiere aus dem Tag-Message

### Schritt 6: Nutzer können es jetzt verwenden!

Andere können es jetzt einbinden mit:

```nix
{
  inputs = {
    linux-dynamic-wallpapers.url = "github:YOUR_USERNAME/linux-dynamic-wallpapers-nix";
  };
}
```

## Option 2: NixOS User Repository (NUR)

Das [NixOS User Repository](https://github.com/nix-community/NUR) ist eine Sammlung von Community-Paketen.

### Voraussetzungen

1. Ein öffentliches GitHub Repository (siehe Option 1)
2. Ein funktionierendes Flake

### Schritte

1. Fork https://github.com/nix-community/NUR
2. Füge dein Repository in `repos.json` hinzu:

```json
{
  "repos": {
    "your-username": {
      "url": "https://github.com/YOUR_USERNAME/linux-dynamic-wallpapers-nix"
    }
  }
}
```

3. Erstelle einen Pull Request
4. Warte auf Review und Merge

### Nutzung via NUR

Nutzer können es dann so verwenden:

```nix
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.packages = [ pkgs.nur.repos.your-username.linux-dynamic-wallpapers ];
}
```

## Option 3: Nixpkgs PR (Langfristig)

Das offizielle nixpkgs Repository ist die beste langfristige Lösung.

### Voraussetzungen

- Stabile, gut getestete Package
- Gute Dokumentation
- Aktive Maintenance-Bereitschaft

### Schritte

1. Fork https://github.com/NixOS/nixpkgs
2. Erstelle das Paket in `pkgs/data/misc/linux-dynamic-wallpapers/`
3. Teste gründlich
4. Erstelle einen PR nach nixpkgs

### Struktur für nixpkgs

```
pkgs/data/misc/linux-dynamic-wallpapers/
├── default.nix
└── home-manager-module.nix (optional, könnte in home-manager repo gehen)
```

### PR Template

```markdown
# linux-dynamic-wallpapers: init at unstable-2024-01-15

## Description

Adds a package for 109+ dynamic wallpapers for GNOME with time-based transitions.

Port of saint-13/Linux_Dynamic_Wallpapers for NixOS.

## Checklist

- [x] Tested on NixOS
- [x] Passes `nix-build -A linux-dynamic-wallpapers`
- [x] Meta attributes set correctly
- [x] License matches upstream (GPL-3.0+)
- [x] Works with Home Manager

## Testing

Tested on NixOS 25.11 with GNOME.
```

## Option 4: Discourse/Reddit Ankündigung

Nach der Veröffentlichung kannst du es bekannt machen:

### NixOS Discourse

Post in https://discourse.nixos.org/c/links/12

```markdown
Title: [Package] Linux Dynamic Wallpapers - 109+ Time-Based Wallpapers for GNOME

I've created a NixOS package for saint-13's Linux Dynamic Wallpapers collection!

## Features
- 109+ dynamic wallpapers with time-based transitions
- Home Manager module for easy installation
- Full GNOME integration

## Installation
See https://github.com/YOUR_USERNAME/linux-dynamic-wallpapers-nix

Feedback welcome!
```

### Reddit

Post in r/NixOS:

```markdown
Title: I made a NixOS package for 109+ Dynamic Wallpapers

Brought the popular Linux_Dynamic_Wallpapers collection to NixOS!
Check it out: https://github.com/YOUR_USERNAME/linux-dynamic-wallpapers-nix

[Screenshot]
```

## Maintenance

### Updates veröffentlichen

Wenn das Original-Repository aktualisiert wird:

```bash
# Hash aktualisieren
nix-shell -p nix-prefetch-github --run \
  "nix-prefetch-github saint-13 Linux_Dynamic_Wallpapers --rev NEW_REV"

# default.nix aktualisieren mit neuem rev und sha256

# Testen
nix build .#linux-dynamic-wallpapers

# Committen
git commit -am "Update to NEW_REV

- Update wallpapers to latest upstream
- New wallpapers: X, Y, Z"

# Tag erstellen
git tag -a v1.1.0 -m "Update to upstream NEW_REV"

# Pushen
git push && git push --tags
```

## Best Practices

1. **Semantic Versioning**: Nutze v1.0.0, v1.1.0, etc.
2. **Changelog**: Führe eine CHANGELOG.md
3. **Tests**: Teste jedes Update auf deinem System
4. **Issues**: Antworte auf GitHub Issues zeitnah
5. **Dokumentation**: Halte README aktuell

## CI/CD (Optional)

Du kannst GitHub Actions nutzen für automatische Tests:

`.github/workflows/build.yml`:

```yaml
name: Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: cachix/install-nix-action@v22
      - name: Build package
        run: nix build .#linux-dynamic-wallpapers
```

## Weitere Ressourcen

- [Nixpkgs Contributing Guide](https://github.com/NixOS/nixpkgs/blob/master/CONTRIBUTING.md)
- [NUR Documentation](https://github.com/nix-community/NUR)
- [Flakes Tutorial](https://nixos.wiki/wiki/Flakes)

Viel Erfolg beim Veröffentlichen! 🚀
