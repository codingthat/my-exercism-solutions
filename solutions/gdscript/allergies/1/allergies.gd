@export var score: int
@export var lst: Array: get = _get_lst
var all_items = [
	"eggs",
	"peanuts",
	"shellfish",
	"strawberries",
	"tomatoes",
	"chocolate",
	"pollen",
	"cats",
]


func allergic_to(item):
	var index = all_items.find(item)
	if index == -1:
		return false
	return score >> index & 1 == 1


func _get_lst():
	var list: Array[String] = []
	for i in len(all_items):
		if score >> i & 1 == 1:
			list.append(all_items[i])
	return list