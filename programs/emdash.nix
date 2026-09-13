{pkgs, ...}: let
  # Emdash: GUI that runs agent CLIs in parallel worktrees. Not in nixpkgs, and
  # upstream's flake (apps/emdash-desktop) ships an empty pnpmDeps hash, so this
  # wraps the release AppImage instead. Bump version and hash together:
  #   nix store prefetch-file https://github.com/generalaction/emdash/releases/download/v<ver>/emdash-x86_64.AppImage
  emdash = pkgs.appimageTools.wrapType2 rec {
    pname = "emdash";
    version = "1.2.4";

    src = pkgs.fetchurl {
      url = "https://github.com/generalaction/emdash/releases/download/v${version}/emdash-x86_64.AppImage";
      hash = "sha256-8+UhbYn6OE7R+6hyR0mx0h6n5H+3i+TWyIsEsbNa4Fs=";
    };

    extraInstallCommands = let
      contents = pkgs.appimageTools.extract {inherit pname version src;};
    in ''
      install -Dm444 ${contents}/Emdash.desktop $out/share/applications/emdash.desktop
      substituteInPlace $out/share/applications/emdash.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=emdash'
      cp -r ${contents}/usr/share/icons $out/share
    '';
  };
in {
  environment.systemPackages = [emdash];
}
