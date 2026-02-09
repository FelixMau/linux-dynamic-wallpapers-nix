{
  description = "109+ dynamic wallpapers for GNOME with time-based transitions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: import nixpkgs { inherit system; };
    in
    {
      # Package output
      packages = forAllSystems (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.callPackage ./default.nix { };
          linux-dynamic-wallpapers = pkgs.callPackage ./default.nix { };
        }
      );

      # Home Manager module
      homeManagerModules.default = import ./home-manager-module.nix;
      homeManagerModules.linux-dynamic-wallpapers = import ./home-manager-module.nix;

      # Overlay for use in system configurations
      overlays.default = final: prev: {
        linux-dynamic-wallpapers = final.callPackage ./default.nix { };
      };

      # NixOS module (for system-wide installation)
      nixosModules.default = { config, lib, pkgs, ... }:
        with lib;
        let
          cfg = config.services.linux-dynamic-wallpapers;
        in
        {
          options.services.linux-dynamic-wallpapers = {
            enable = mkEnableOption "Linux Dynamic Wallpapers (system-wide)";
          };

          config = mkIf cfg.enable {
            environment.systemPackages = [
              (pkgs.callPackage ./default.nix { })
            ];

            # Make wallpapers available system-wide
            environment.pathsToLink = [
              "/share/backgrounds"
              "/share/gnome-background-properties"
            ];
          };
        };
    };
}
