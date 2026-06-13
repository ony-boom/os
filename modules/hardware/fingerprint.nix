{
  pkgs,
  config,
  ...
}: {
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix; # Goodix driver module

  # SDDM authenticates through the "login" PAM substack (its own PAM service
  # uses useDefaultRules = false and only does `auth substack login`), so
  # fingerprint at the login screen is governed by login.fprintAuth — NOT
  # sddm.fprintAuth, which is a no-op. This is true by default when fprintd is
  # enabled; set explicitly to document intent.
  security.pam.services.login.fprintAuth = true;

  # By default NixOS orders pam_fprintd *before* pam_unix, so PAM always waits
  # for a fingerprint swipe even when you've typed your password. Move fprintd
  # to just after pam_unix so a typed password logs in instantly, and the
  # fingerprint is only used when the password field is left empty.
  # (Relative offset per the warning in nixos/modules/security/pam.nix.)
  security.pam.services.login.rules.auth.fprintd.order =
    config.security.pam.services.login.rules.auth.unix.order + 10;
}
