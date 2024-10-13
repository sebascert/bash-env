last-core() {
    local latest_file=""
    local latest_time=0

    for file in core.*; do
        if [[ -f "$file" ]]; then
            file_time=$(stat -c %W "$file")

            if [[ $file_time -eq 0 ]]; then
                file_time=$(stat -c %Y "$file")
            fi

            if [[ $file_time -gt $latest_time ]]; then
                latest_time=$file_time
                latest_file="$file"
            fi
        fi
    done

    echo "$latest_file"
}
