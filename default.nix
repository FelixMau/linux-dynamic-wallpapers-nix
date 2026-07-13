{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "linux-dynamic-wallpapers";
  version = "unstable-2024-01-15";

  # Fetch from GitHub:
  src = fetchFromGitHub {
    owner = "saint-13";
    repo = "Linux_Dynamic_Wallpapers";
    rev = "45128514ae51c6647ab3e427dda2de40c74a40e5";
    sha256 = "sha256-gmGtu28QfUP4zTfQm1WBAokQaZEoTJ2jL/Qk4BUNrhU=";
  };

  # Or use local path for testing (requires --impure flag):
  # src = /home/felix/Linux_Dynamic_Wallpapers;

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    # Create output directories
    mkdir -p $out/share/backgrounds/Dynamic_Wallpapers
    mkdir -p $out/share/gnome-background-properties

    # Copy all wallpaper directories and images
    cp -r Dynamic_Wallpapers/* $out/share/backgrounds/Dynamic_Wallpapers/

    # Process XML files: patch paths and create GNOME properties
    for xml in Dynamic_Wallpapers/*.xml; do
      if [ -f "$xml" ]; then
        name=$(basename "$xml" .xml)

        # Patch XML file to use correct output path
        sed "s|/usr/share/backgrounds/Dynamic_Wallpapers|$out/share/backgrounds/Dynamic_Wallpapers|g" \
          "$xml" > "$out/share/backgrounds/Dynamic_Wallpapers/$(basename "$xml")"

        # Create GNOME background property file
        cat > "$out/share/gnome-background-properties/$name.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>$name</name>
    <filename>$out/share/backgrounds/Dynamic_Wallpapers/$(basename "$xml")</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
    <pcolor>#000000</pcolor>
    <scolor>#000000</scolor>
  </wallpaper>
</wallpapers>
EOF
      fi
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Collection of 109+ dynamic wallpapers for GNOME with time-based transitions";
    longDescription = ''
      A comprehensive collection of dynamic wallpapers that change throughout the day
      based on time. Includes nature scenes, abstract designs, Apple-style wallpapers,
      and more. Unlike simple light/dark wallpapers, these feature smooth transitions
      between multiple images throughout a 24-hour cycle.
    '';
    homepage = "https://github.com/saint-13/Linux_Dynamic_Wallpapers";
    changelog = "https://github.com/saint-13/Linux_Dynamic_Wallpapers/commits/main";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; ["FelixMau"];
  };
}
