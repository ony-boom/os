.PHONY: link-dotfiles rebuild rebuild-remote all

# Public IP, not the ts.net name: Tailscale SSH intercepts port 22 on the
# tailnet and demands periodic browser re-auth, which breaks non-interactive
# builds. Plain sshd + ony's key on the public IP is what colmena already uses.
BUILD_HOST := ony@94.250.201.16

all: rebuild


# Render dotfiles into ~ with chezmoi. Files are COPIES, not symlinks:
# re-run this after editing. Host differences live in *.tmpl files keyed on
# {{ .chezmoi.hostname }}. Source layout: dot_config/ → ~/.config, dot_ssh/ → ~/.ssh.
# Migrating from stow? Remove the old symlinks first:
#   stow -D --target ~/.config dotfiles
link-dotfiles:
	chezmoi apply --source $(CURDIR)/dotfiles --destination ~

# Preview what link-dotfiles would change.
diff-dotfiles:
	chezmoi diff --source $(CURDIR)/dotfiles --destination ~

# Build locally on maki (default). With the cache fix in place, prebuilt deps
# are substituted from the caches instead of compiled.
rebuild:
	sudo nixos-rebuild --accept-flake-config switch

# Offload the build to the VPS: maki ships the derivation up, the VPS fetches
# deps and compiles, and only the result is copied back. Useful when something
# must compile from source and you don't want maki to do it.
# --sudo instead of a leading sudo: the ssh to the build host must run as ony
# (root has no key for hizuru); nixos-rebuild elevates only for activation.
rebuild-remote:
	nixos-rebuild switch --accept-flake-config --sudo --build-host $(BUILD_HOST)
