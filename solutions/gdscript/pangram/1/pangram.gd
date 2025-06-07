func is_pangram(sentence):
	var present: Array[bool] = []
	present.resize(26)
	present.fill(false)
	for i in range(sentence.length()):
		var codepoint = sentence.unicode_at(i)
		if codepoint in range(97, 123):
			present[codepoint - 97] = true
		elif codepoint in range(65, 91):
			present[codepoint - 65] = true
	for i in range(26):
		if !present[i]:
			return false
	return true
