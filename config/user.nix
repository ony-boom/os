{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  users.users.ony = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$faLiVjJgTMyExiZ1$4rmYx.HL1RRxxCI6CCfOOZ5M8VuwZSC6mPmVxmnxJliyXGYMFwDHDx40XPAv1NilOCvlj6jMFgq9bJqpoqGhj/";
  };
}
