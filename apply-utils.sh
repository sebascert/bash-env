# !/bin/bash

cp config/.bashrc 	~/.bashrc
cp config/.bash_aliases ~/.bash_aliases

cp -r functions 	~/functions
sudo cp scripts/*.sh 	/usr/local/bin

# restart session
bash

