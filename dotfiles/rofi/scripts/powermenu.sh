#!/usr/bin/env bash

shutdown="󰤁"
reboot="󰑓"
suspend=""
lock=""
logout=""

# ---------- Helpers ----------
rofi_menu() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" \
        | rofi -dmenu -i -p "Power Menu" -config powermenu.rasi
}

# ---------- Actions ----------
do_shutdown() {
     systemctl poweroff
}

do_reboot() {
    systemctl reboot
}

do_suspend() {
    loginctl terminate-session "$XDG_SESSION_ID"
}

do_lock() {
    if command -v hyprlock &>/dev/null; then
        hyprlock
    elif command -v i3lock &>/dev/null; then
        i3lock
    fi
}

do_logout() {
    hyprctl dispatch exit 0
}

# ---------- Main ----------
choice="$(rofi_menu)"
case "$choice" in
    "$shutdown") do_shutdown ;;
    "$reboot")   do_reboot ;;
    "$suspend")  do_suspend ;;
    "$lock")     do_lock ;;
    "$logout")   do_logout ;;
esac

