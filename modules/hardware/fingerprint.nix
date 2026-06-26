{pkgs, ...}: {
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module

  # Fingerprint login is DISABLED at the SDDM/login screen on purpose.
  #
  # SDDM authenticates through the "login" PAM substack, so the login screen is
  # governed by login.fprintAuth (sddm.fprintAuth is a no-op here). A fingerprint
  # swipe cannot supply the account password that pam_gnome_keyring needs to
  # unlock the login keyring, so a fingerprint login left the keyring locked and
  # Chrome (and ssh/git via gcr) raised an "unlock keyring" prompt. Requiring a
  # typed password at login lets pam_gnome_keyring unlock the keyring for free.
  #
  # fprintd stays enabled so the reader is still usable for PAM services where
  # the keyring isn't involved (e.g. sudo), should those opt in via fprintAuth.
  security.pam.services.login.fprintAuth = false;
}
