{
  self,
  config,
  ...
}: let
  home = config.users.users."ony".home;
in {
  age.identityPaths = ["${home}/.ssh/agenix" "${home}/.ssh/id_ed25519"];
  age.secrets.cachix-auth-token = {
    file = self + /secrets/cachix-auth-token.age;
    mode = "770";
    owner = "ony";
    group = "users";
  };
}
