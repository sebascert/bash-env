cp_clip() {
    printf "%s" "$*" | xclip -selection clipboard
}
