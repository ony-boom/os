{
  pkgs,
  stable-pkgs,
  inputs,
  ...
}: {
  imports = [
    ./wm
    ./neovim.nix
    ./terminal.nix
    ./vm-stuff.nix
    ./programming.nix
  ];

  # base packages
  environment.systemPackages = with pkgs;
    [
      wget
      curl
      ffmpeg
      p7zip
      peazip

      # thumbnail things
      imagemagick
      ffmpegthumbnailer

      glow
      bottom

      gnumake # make
      stow # for dotfiles because hm is annoying

      loupe
      cheese
      nautilus
      baobab
      gnome-disk-utility
      refine

      # Plain Chrome here; NVIDIA hosts patch it to force the X11/XWayland
      # backend via an overlay in modules/hardware/nvidia.nix (works around
      # broken VA-API decode under Chrome's native Wayland path).
      google-chrome

      ghostty

      pavucontrol

      vlc
      spotify
      obs-studio
      discord

      feishin
      trayscale
      vicinae
      wl-clipboard

      playerctl

      agenix

      onlyoffice-desktopeditors
      zed-editor
      zen-browser
    ]
    ++ (
      with stable-pkgs; [
        bruno
      ]
    );

  programs = {
    openscreen = {
      enable = true;
      # Upstream's flake records a stale npmDepsHash for its own lockfile, so the
      # npm-deps FOD fails to verify. Override the fetcher's output hash with the
      # value Nix actually computes. TODO: Drop this once upstream fixes its hash.
      package = inputs.openscreen.packages.${pkgs.stdenv.hostPlatform.system}.openscreen.overrideAttrs (old: {
        npmDeps = old.npmDeps.overrideAttrs (_: {
          outputHash = "sha256-7eW9p1yMB+36pNdBP5SP9W/d8IiBaER7LD2h1Q1V0+w=";
        });
      });
    };
    seahorse.enable = true;
    localsend.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
    git.enable = true;
  };
}
