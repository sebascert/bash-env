# Bash Environment

Dotfiles, configuration and utilities for my command-line environment

## Features

- Customizable config environments:
  `home` configs, installed in the user home dir.
  `bin` configs, installed in /usr/local/bin.
  Add your own environments
- Mapped environments: map each environment to it's destination on your system
  Use the format `/path/in/repo=path/in/system`.
- Install utility: Installs environments with various options
- Copy utility: Copies the common files from your installed envs to the repo envs
- Diff-env utility: Outputs differences between installed envs and repo envs


## Installation

Clone the repository:
```bash
git clone https://github.com/YoAquinJs/bash-env
cd bash-env
# for immediate install
./install --all --source
```

## Usage

### Install tool

```bash
# help option
source install.sh --help

# use --all or -a to install all environments
source install.sh --all

# use --force or -f to avoid the initial prompt
source install.sh -all --force

# use --source or -so to source your $HOME/.bashrc
source install.sh --all --source

# use --copy or -cp to copy your env to the repo env
source install.sh --all --copy
```

### Diff tool

```bash
# help option
./diff-env.sh --help

# use --all or -a to diff all environments
./diff-env.sh --all
```

## License

This project is licensed under the MIT License,
see the [license](LICENSE-MIT.txt) file for details.
