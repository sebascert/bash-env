cp-last ()  {
	cp-clip $(history | tail -n 2 | head -n 1 | sed 's/^[ ]*[0-9]*[ ]*//')
}
