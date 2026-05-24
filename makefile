.PHONY: link-dotfiles rebuild rebuild-remote all

BUILD_HOST := ony@hizuru.tempel-goblin.ts.net

all: rebuild


link-dotfiles:
	stow --target ~/.config dotfiles

# Build locally on maki (default). With the cache fix in place, prebuilt deps
# are substituted from the caches instead of compiled.
rebuild:
	sudo nixos-rebuild switch --flake .#maki

# Offload the build to the VPS: maki ships the derivation up, the VPS fetches
# deps and compiles, and only the result is copied back. Useful when something
# must compile from source and you don't want maki to do it.
rebuild-remote:
	sudo nixos-rebuild switch --flake .#maki --build-host $(BUILD_HOST)
