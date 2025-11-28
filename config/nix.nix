{
  nix.settings = {
    trusted-users = ["root" "ony"];
    experimental-features = ["nix-command" "flakes"];
  };
  nixpkgs.config.allowUnfree = true;
}
