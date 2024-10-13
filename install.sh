# Dependencies: rsync, find, get-environments.sh

installEnv() {
    if [[ ! -v environments["$1"] ]]; then
        echo "environment '$1' not mapped"
        return 1
    fi

    origin=$(eval "echo $1")
    dest=$(eval "echo ${environments["$1"]}")
    if [ $copy = false ]; then
        rsync -avh --no-perms "$origin"/ "$dest"/
    else
        rsync -avh --no-perms --existing "$dest"/ "$origin"/

        # remove all files that have been removed on dest
        find "$origin"/ -type f | while read -r file; do
            file="${file#"$origin/"}"
            diff "$origin/$file" "$dest/$file" &> /dev/null

            if [[ $? -ne 2 || -f "$dest/$file" ]]; then
                continue
            fi

            rm "$origin/$file"
            echo "removed '$origin/$file'"
        done
    fi
}

usage() {
    echo "Usage: $0 [--all ^env1 ^env2 ...|env1 env2 ...] [OPTIONS]..."
    echo
    echo "when the --all flag is provided, envs passed are ignored"
    echo "the copy option will copy the files from the installed env to the repo env"
    echo "deleting env files which are not installed"
    echo -e "\nOptions:\n"
    echo -e "-h, --help \t display usage and exit"
    echo -e "-a, --all \t install all environments"
    echo -e "-cp, --copy \t copies the installed env to the repo env"
    echo -e "-so, --source \t sources your .bashrc after install"
    echo -e "-f, --force \t skips y/n prompt"
}

all=false
source=false
copy=false
force=false

unset selected_envs
declare -A selected_envs

# parse command-line options
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -a|--all)
            all=true
            ;;
        -cp|--copy)
            copy=true
            ;;
        -so|--source)
            source=true
            ;;
        -f|--force)
            force=true
            ;;
        -h|--help)
            usage
            return 0
            ;;
        *)
            if [[ -v selected_envs["$1"] ]]; then
                usage
                echo "repeated environments"
                return 1
            fi

            # ensure all paths don't have / for rsync to work
            env="${1%/}"

            selected_envs["$env"]=1
            ;;
    esac
    shift
done

if [[ $all = false && ${#selected_envs[@]} -eq 0 ]]; then
    echo "nothing to do"
    return 0
fi

if [ $force = false ]; then
    echo "This may overwrite existing files in your system"
    echo "For viewing which files will be overridden use diff-env"
    read -p "Are you sure? (y/n) " -n 1
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 1
    fi
fi

cd "$(dirname "${BASH_SOURCE[0]}")" || return 1

source "./get-environments.sh"

if [ $? -eq 1 ]; then
    return 1
fi

if [ $all = true ]; then
    for env in "${!environments[@]}"; do
        if [[ -v selected_envs["$env"] ]]; then
            unset 'selected_envs["$env"]'
        else
            selected_envs["$env"]=1
        fi
    done
fi

for env in "${!selected_envs[@]}"; do
    installEnv "$env"
    if [ $? -eq 1 ]; then
        return 1
    fi
done

if [ $source = true ]; then
    source "$HOME/.bashrc"
fi

cd - > /dev/null|| return 1
return 0
