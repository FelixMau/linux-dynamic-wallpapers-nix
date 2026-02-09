# Beispiel: Integration in home.nix
#
# Dieses Beispiel zeigt verschiedene Methoden, wie du Linux Dynamic Wallpapers
# in deiner Home Manager Konfiguration verwenden kannst.

{ config, pkgs, lib, ... }:

{
  # === METHODE 1: Einfach (mit dem mitgelieferten Modul) ===

  imports = [
    ./pkgs/linux-dynamic-wallpapers/home-manager-module.nix
  ];

  programs.linux-dynamic-wallpapers.enable = true;

  # === METHODE 2: Manuell (mehr Kontrolle) ===

  # home.packages = with pkgs; [
  #   linux-dynamic-wallpapers
  # ];

  # xdg.dataFile = {
  #   "backgrounds/Dynamic_Wallpapers" = {
  #     source = "${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers";
  #     recursive = true;
  #   };
  #   "gnome-background-properties" = {
  #     source = "${pkgs.linux-dynamic-wallpapers}/share/gnome-background-properties";
  #     recursive = true;
  #   };
  # };

  # === OPTIONAL: Standard-Wallpaper setzen ===

  # Setze einen dynamischen Wallpaper als Standard
  # dconf.settings = {
  #   "org/gnome/desktop/background" = {
  #     picture-uri = "file://${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers/BigSur.xml";
  #     picture-uri-dark = "file://${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers/BigSur.xml";
  #     picture-options = "zoom";
  #   };
  # };

  # === Beliebte Wallpaper-Optionen ===
  #
  # Hier sind einige der beliebtesten dynamischen Wallpapers:
  #
  # - BigSur.xml          - macOS Big Sur Berge (8 verschiedene Tageszeiten)
  # - Monterey.xml        - macOS Monterey Wellen
  # - Mojave.xml          - macOS Mojave Wüste
  # - Firewatch.xml       - Firewatch-inspirierte Landschaft
  # - LofiGirl.xml        - Lofi-Ästhetik Zimmer
  # - Lakeside.xml        - Friedlicher See
  # - Mountains.xml       - Berglandschaft
  # - Nord.xml            - Nord Theme Farbschema
  # - Ubuntu.xml          - Ubuntu-inspiriert
  # - Windows11.xml       - Windows 11 Style
  #
  # Alle verfügbaren Wallpapers findest du in:
  # ${pkgs.linux-dynamic-wallpapers}/share/backgrounds/Dynamic_Wallpapers/
}
