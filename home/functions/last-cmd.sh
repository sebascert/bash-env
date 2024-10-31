last-cmd(){
    last=${1:-1}
    ((last++))
    history | tail -n "$last" | head -n1 | cut -d " " -f 4-
}
