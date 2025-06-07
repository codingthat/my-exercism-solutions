func flatten(iterable):
	var flat = []
	for i in iterable:
		if typeof(i) == TYPE_ARRAY:
			flat += flatten(i)
		elif i != null:
			flat.append(i)
	return flat