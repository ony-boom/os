{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  security.pam.services.gdm-password.enableGnomeKeyring = true;
  security.pam.services.gdm-launch-environment.enableGnomeKeyring = true;
}
