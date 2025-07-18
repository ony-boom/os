{name, ...}: {
  imports = [
    ./defaults
  ];

  services.openssh.enable = true;

  users.users = let
    publicKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+IhjgxWSqhWo6ER2Gw4qyRb5JS7ioJIAKRZFJaId/y ony@maki"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0tFY9NpB6eoYbbsH4OKxmUNKLo+lSG/l/INATD8uis ony@BCS-MG-LP-0120-09"
    ];
  in {
    ony = {
      isNormalUser = true;
      #TODO: Change this password, after the first login;
      initialPassword = "changeme";
      extraGroups = ["wheel" "networkmanager"];
      openssh.authorizedKeys.keys = publicKeys;
    };
    root = {
      openssh.authorizedKeys.keys = publicKeys;
    };
  };

  networking = {
    hostName = name;
    firewall = {
      allowedTCPPorts = [22 80 443];
    };
  };

  nix = {
    settings = {
      trusted-users = ["ony" "root"];
      trusted-substituters = [
        "https://ony-boom.cachix.org"
      ];
      trusted-public-keys = [
        "ony-boom.cachix.org-1:rPOTyyOCiAhLarertCrNnZLxsBFpcirEekoohcCZt10="
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "25.05";
}
