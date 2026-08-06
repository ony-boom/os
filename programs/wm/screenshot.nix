{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    satty

    # `dms screenshot` handles the capture (region select, output picking,
    # scroll stitching); satty handles the drawing on top. `--stdout` exists
    # precisely for this hand-off, so the pixels never touch a file unless
    # satty saves them.
    #
    # Bound to SHIFT + Print in the Hyprland config; plain Print stays the
    # straight capture-and-copy path.
    (writeShellApplication {
      name = "screenshot-annotate";
      runtimeInputs = [satty wl-clipboard coreutils];
      text = ''
        dir="''${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
        mkdir -p "$dir"

        shot=$(mktemp -t screenshot-XXXXXXXX.png)
        trap 'rm -f "$shot"' EXIT

        # "$@" forwards the capture mode (region/full/window/...) untouched.
        dms screenshot "$@" --stdout --no-file --no-clipboard --no-notify >"$shot"

        # Empty file means the selection was cancelled — nothing to annotate.
        [ -s "$shot" ] || exit 0

        satty \
          --filename "$shot" \
          --output-filename "$dir/satty-%Y%m%d-%H%M%S.png" \
          --copy-command wl-copy \
          --early-exit \
          --initial-tool arrow \
          --actions-on-enter save-to-clipboard \
          --actions-on-enter save-to-file
      '';
    })
  ];
}
