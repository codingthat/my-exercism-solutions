func convert(number: int):
	var result = ""
	if number % 3 == 0:
		result += "Pling"
	if number % 5 == 0:
		result += "Plang"
	if number % 7 == 0:
		result += "Plong"
	if result.length() > 0:
		return result
	return str(number)
