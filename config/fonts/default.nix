{pkgs, ...}: let
  entries = builtins.readDir ./files;

  fontDirs =
    builtins.filter
    (name: entries.${name} == "directory")
    (builtins.attrNames entries);

  mkFontPackage = name:
    pkgs.runCommandLocal "font-${name}" {} ''
      mkdir -p $out/share/fonts/truetype/${name}
      cp ${./files + "/${name}"}/*.{ttf,otf,woff,woff2} \
        $out/share/fonts/truetype/${name}/ 2>/dev/null || true
    '';

  localFonts = map mkFontPackage fontDirs;
in {
  fonts = {
    packages =
      localFonts
      ++ (with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.hasklug
        nerd-fonts.iosevka
        maple-mono.NF
        openmoji-color
        twitter-color-emoji
      ]);

    fontconfig.defaultFonts = {
      monospace = ["Iosevka Nerd Font" "Maple Mono NF"];
      emoji = ["Twitter Color Emoji"];
    };
  };
}
