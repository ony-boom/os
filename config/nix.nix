{
  nix.settings = {
    extra-substituters = ["https://vicinae.cachix.org"];
    extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
    trusted-users = ["root" "ony"];

    experimental-features = ["nix-command" "flakes"];
  };
  nixpkgs.config.allowUnfree = true;
}
