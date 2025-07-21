func egg_count(display_value):
	var count = 0
	while display_value > 0:
		count += display_value & 1
		display_value >>= 1
	return count