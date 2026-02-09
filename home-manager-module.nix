{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.linux-dynamic-wallpapers;

  # Call the package directly instead of expecting it from pkgs
  linux-dynamic-wallpapers-pkg = pkgs.callPackage ./default.nix {};
in
{
  options.programs.linux-dynamic-wallpapers = {
    enable = mkEnableOption "Linux Dynamic Wallpapers collection";

    package = mkOption {
      type = types.package;
      default = linux-dynamic-wallpapers-pkg;
      defaultText = literalExpression "pkgs.linux-dynamic-wallpapers";
      description = "The linux-dynamic-wallpapers package to use.";
    };

    forceOverwrite = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to force overwrite existing wallpaper files.
        If set to false and conflicts exist, the activation will fail with an error message.
        Enable this if you have existing dynamic wallpapers you want to replace.
      '';
    };

    defaultWallpaper = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "BigSur";
      description = ''
        Set a default dynamic wallpaper. This should be the name without the .xml extension.
        Available wallpapers can be found in the package's share directory.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # Make wallpapers available to GNOME
    xdg.dataFile = {
      "backgrounds/Dynamic_Wallpapers" = {
        source = "${cfg.package}/share/backgrounds/Dynamic_Wallpapers";
        recursive = true;
        force = cfg.forceOverwrite;
      };
      "gnome-background-properties" = {
        source = "${cfg.package}/share/gnome-background-properties";
        recursive = true;
        force = cfg.forceOverwrite;
      };
    };

    # Set default wallpaper if specified
    dconf.settings = mkIf (cfg.defaultWallpaper != null) {
      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.home.homeDirectory}/.local/share/backgrounds/Dynamic_Wallpapers/${cfg.defaultWallpaper}.xml";
        picture-uri-dark = "file://${config.home.homeDirectory}/.local/share/backgrounds/Dynamic_Wallpapers/${cfg.defaultWallpaper}.xml";
        picture-options = "zoom";
      };
    };
  };
}
