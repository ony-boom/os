.PHONY: link-dotfiles rebuild rebuild-remote push-makima makima-cache all

# Public IP, not the ts.net name: Tailscale SSH intercepts port 22 on the
# tailnet and demands periodic browser re-auth, which breaks non-interactive
# builds. Plain sshd + ony's key on the public IP is what colmena already uses.
BUILD_HOST := ony@94.250.201.16

# makima's address. It force-disables Tailscale (hosts/makima/default.nix) and
# rides netbird instead, so there is no stable name to hardcode: pass the LAN or
# netbird IP on the command line, e.g. `make push-makima HOST=192.168.88.57`.
HOST ?= makima
MAKIMA := ony@$(HOST)

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

# Update makima WITHOUT it re-downloading the world. After a `nix flake update`
# the stdenv rerolls and every store path changes, so a makima-side rebuild
# would pull the whole multi-GB closure from cache.nixos.org. maki has already
# paid that cost: the two hosts share nearly the entire closure, and building
# makima's toplevel here needs only ~76 MiB on top of what maki holds.
#
# So: build here, ship only the closure over the LAN/netbird link. No
# --substitute-on-destination, precisely so makima fetches nothing itself.
# Locally-built paths are unsigned; that is fine because ony is a trusted-user
# on both hosts (config/nix.nix). --sudo elevates only for activation on makima,
# the ssh itself runs as ony.
#
# Check the transfer first with:  make push-makima HOST=<ip> ARGS=--dry-run
push-makima:
	nixos-rebuild switch --accept-flake-config --flake .#makima \
		--target-host $(MAKIMA) --sudo $(ARGS)

# Offline variant: makima not reachable from maki. Dump its closure onto a USB
# drive as a binary cache, carry it over, then rebuild on makima with that
# directory as the only substituter. DIR defaults to a mounted stick.
DIR ?= /run/media/ony/usb/nixcache
makima-cache:
	nix copy --accept-flake-config --to file://$(DIR) \
		.#nixosConfigurations.makima.config.system.build.toplevel
	@echo
	@echo "Now on makima, from a checkout of this repo at the same commit:"
	@echo "  sudo nixos-rebuild switch --flake .#makima \\"
	@echo "    --option substituters file://$(DIR) --option require-sigs false"
