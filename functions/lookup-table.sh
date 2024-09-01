lookup-table() {
	local table="$1"
	local key="$2"
	local sep="${3:-=}"
	
	local result=$(grep "^$key$sep" "$table" | cut -d"$sep" -f2)
	
	if [ -z "$result" ]; then
		cat "$table"
	else
		echo "$result"
	fi
}
