#!/bin/bash 

# Gets the default terminal emulator name and search for any running
# process of it, if none start's one, then focus it's window

# Dependencies: x-terminal-emulator, wmctrl

terminal=$(readlink -f /usr/bin/x-terminal-emulator | xargs basename)

# wmctrl may not found the window if it's name and class differ from
# the terminals executable name

wmctrl -a "$terminal"
if [ $? -eq 1 ]; then # if not found try by class name
	wmctrl -xa "$terminal"
fi

# window not found
if [ $? -eq 1 ]; then
	echo "terminal $terminal not found among running process" >&2
	nohup $terminal &
fi

