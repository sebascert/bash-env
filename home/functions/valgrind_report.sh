valgrind_report() {
    local in
    local valgrind_out="report.vg"

    read in

    echo "$in" | valgrind "$*" 2> "report.vg"

    nvim -c 'set ft=valgrind wrap' "$valgrind_out"
}
