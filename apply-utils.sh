# !/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$BASH_SOURCE")")"
restart=false

usage() {
    	echo "Usage: $0 [-restart]"
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -restart)
      restart=true
    ;;
    *)
      usage
      exit 1
    ;;
  esac
  shift
done

# Bash config
cp "$SCRIPT_DIR/config/.bashrc"       "$HOME/.bashrc"
cp "$SCRIPT_DIR/config/.bash_aliases" "$HOME/.bash_aliases"

# Functions
functionsDir="$HOME/functions"
if [ -d "$functionsDir" ]; then
  rm -r "$functionsDir"
fi
cp -r "$SCRIPT_DIR/functions" "$functionsDir"

# App-Setup
appsetupDir="$HOME/app-setup"
if [ -d "$appsetupDir" ]; then
  rm -r "$appsetupDir"
fi
cp -r "$SCRIPT_DIR/app-setup" "$appsetupDir"

# Scripts

sudo cp "$SCRIPT_DIR/scripts"/*.sh "/usr/local/bin"

# restart session
if [ $restart = true ]; then
  bash
fi
