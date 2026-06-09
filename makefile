.PHONY: link-dotfiles rebuild rebuild-remote all

BUILD_HOST := ony@hizuru.tempel-goblin.ts.net

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
	sudo nixos-rebuild switch

# Offload the build to the VPS: maki ships the derivation up, the VPS fetches
# deps and compiles, and only the result is copied back. Useful when something
# must compile from source and you don't want maki to do it.
rebuild-remote:
	sudo nixos-rebuild switch --build-host $(BUILD_HOST)
