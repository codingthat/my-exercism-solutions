func is_isogram(string: String):
	var present: Array[bool] = []
	present.resize(26)
	present.fill(false)
	for i in range(string.length()):
		var codepoint = string.unicode_at(i)
		if codepoint in range(97, 123):
			codepoint -= 32
		if codepoint in range(65, 91):
			if present[codepoint - 65]:
				return false
			present[codepoint - 65] = true
	return true