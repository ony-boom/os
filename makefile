.PHONY: link-dotfiles rebuild rebuild-remote all

BUILD_HOST := ony@hizuru.tempel-goblin.ts.net
HOST := $(shell hostname -s)

all: rebuild


# Stow the shared defaults, then layer this host's overlay on top.
# --no-folding keeps ~/.config/<app>/ as real dirs so both packages can drop
# files into the same dir without conflicting (e.g. hypr/host.lua on makima).
link-dotfiles:
	stow --no-folding --target ~/.config dotfiles
	@if [ -d hosts-dotfiles/$(HOST) ]; then \
		stow --no-folding --target ~/.config --dir hosts-dotfiles $(HOST); \
	else \
		echo "no host overlay for $(HOST), skipping"; \
	fi

# Build locally on maki (default). With the cache fix in place, prebuilt deps
# are substituted from the caches instead of compiled.
rebuild:
	sudo nixos-rebuild switch

# Offload the build to the VPS: maki ships the derivation up, the VPS fetches
# deps and compiles, and only the result is copied back. Useful when something
# must compile from source and you don't want maki to do it.
rebuild-remote:
	sudo nixos-rebuild switch --build-host $(BUILD_HOST)
