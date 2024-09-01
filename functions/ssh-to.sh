ssh-to() {
	local host="$1"
	ssh $(lookup-table ~/.ssh/hosts $host)
}
