{self, ...}: {
  age.secrets.cachix-auth-token.file = self + /secrets/cachix-auth-token.age;
}
