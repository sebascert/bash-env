# sources all envs defined in the env mapping

env_map="env-map.txt"

unset environments
declare -A environments

if [ ! -f "$env_map" ]; then
    echo "missing environments mappings file '$env_map'"
    return 1
fi

while IFS=":" read -r env_dir dest_dir; do
    if [[ -v environments["$env_dir"] ]]; then
        echo "The config directory '$env_dir' is repeated"
        return 1
    fi

    # ensure all paths don't have / for rsync to work
    env_dir="${env_dir%/}"
    dest_dir="${dest_dir%/}"

    environments["$env_dir"]="$dest_dir"

done < "$env_map"
