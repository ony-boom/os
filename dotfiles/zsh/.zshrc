alias ls='eza --icons=always'
alias lg='lazygit'


# PATHS
BUN_BIN="$XDG_CACHE_HOME/.bun/bin"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export GOPATH="$HOME/go"
export XDG_BIN_HOME="$HOME/.local/bin"
# export JAVA_HOME="$HOME/.nix-profile/lib/openjdk"
export PATH="$PATH:$XDG_BIN_HOME:$GOPATH/bin:$PNPM_HOME:$BUN_BIN"

# Android stuff
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/platform-tools


# Lazy to configure prompt
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
