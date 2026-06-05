{
  services.gnome.gnome-keyring.enable = true;

  # Keyring-backed ssh agent: SSH_AUTH_SOCK -> $XDG_RUNTIME_DIR/gcr/ssh.
  # Enabled implicitly by gnome-keyring, pinned here so the dependency is
  # visible — git/ssh hang forever if this socket has no working backend.
  services.gnome.gcr-ssh-agent.enable = true;

  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  # Keep the login keyring password in sync when the account password changes.
  # A drifted keyring password makes PAM unlock fail silently, so gcr raises a
  # prompt at git/ssh time — which is what "ssh-add is stuck" looks like.
  security.pam.services.passwd.enableGnomeKeyring = true;
}
