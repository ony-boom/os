.PHONY: link-dotfiles rebuild all


all: rebuild


link-dotfiles:
	stow --target ~/.config dotfiles

rebuild:
	sudo nixos-rebuild switch
