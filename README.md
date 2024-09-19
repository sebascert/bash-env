# Bash Enviroment

Dotfiles, configuration and utilities for my command-line enviroment

## Features

- Different config scopes:
  `home` configs, installed in the user home dir.
  `bin` configs, installed in /usr/local/bin.
  `mapped` configs, install each file in it's corresponding mapped path.
- Mapped configs: Map files under `./mapped` in the `mapped-files.txt`.
  Use the format `/path/in/mapped=path/in/system`.
  Warns the user when unmapped files are left in an `./install.sh`
- Diff-env utility: Outputs which files in the enviroment differ from the config files.
  

## Installation

Clone the repository:
   ```bash
   git clone https://github.com/YoAquinJs/bash-env
   cd bash-enn
   # for inmediate install
   ./install --home --bin --mapped
   ```

## Usage

### Install tool

```bash
# add the -f or --force flag for skiping the confirmation
# use any combination of home bin or mapped
./install.sh --home --bin --mapped
```

### Diff tool

```bash
# use only one of home, bin or mapped
./diff-env.sh --home
./diff-env.sh --bin
./diff-env.sh --mapped
```
## License

This project is licensed under the MIT License, see the [license](LICENSE-MIT.txt) file for details.
