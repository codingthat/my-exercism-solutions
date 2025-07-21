@export var tonic: String
const other_flat_keys = ["F", "d", "g", "c", "f"]
const interval_names = ["m", "M", "A"]

func chromatic():
	return interval("m".repeat(11))

func interval(intervals):
	var scale = []
	var flat = (len(tonic) == 2 and tonic[1] == "b") or tonic in other_flat_keys
	scale.append(tonic.capitalize())
	for i in len(intervals):
		scale.append(add_interval(scale[-1], interval_names.find(intervals[i]) + 1, flat))
	return scale

func add_interval(start, steps, flat):
	var code = start.unicode_at(0) - 65
	var from_a = code * 2 - int(code > 1) - int(code > 4)
	if len(start) > 1:
		if start[1] == "b":
			from_a -= 1
		else:
			from_a += 1
	from_a += steps
	var letters = (from_a + int(from_a > 2) + int(from_a > 7)) / 2
	if from_a % 12 in [1, 4, 6, 9, 11]:
		if flat:
			return String.chr(65 + ((letters + 1) % 7)) + "b"
		else:
			return String.chr(65 + (letters % 7)) + "#"
	return String.chr(65 + (letters % 7))