# !/bin/bash

# Bash config
cp config/.bashrc 	~/.bashrc
cp config/.bash_aliases ~/.bash_aliases

# Functions
functionsDir="$HOME/functions"
if [ -d $functionsDir ]; then
  rm -r $functionsDir
fi
cp -r functions 	$functionsDir

# App-Setup
appsetupDir="$HOME/app-setup"
if [ -d $appsetupDir ]; then
  rm -r $appsetupDir
fi
cp -r app-setup 	$appsetupDir

# Scripts
sudo cp scripts/*.sh 	/usr/local/bin

# restart session
bash

