let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHq8bcOlccMFzKUaDy8qp46jkHnNcq690Q/ECYAbjS0a ony@maki";
in {
  "cachix-auth-token.age".publicKeys = [agenix];
}
