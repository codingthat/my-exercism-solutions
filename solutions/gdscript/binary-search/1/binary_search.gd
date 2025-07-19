func find(search_list: Array, value: int):
	if search_list.size() == 0:
		return false
	var low = 0
	var high = search_list.size() - 1
	while low <= high:
		var mid = (high - low) / 2 + low
		if search_list[mid] == value:
			return mid
		elif search_list[mid] < value:
			low = mid + 1
		else:
			high = mid - 1
	return false