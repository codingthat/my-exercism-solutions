func score(x, y):
	match Vector2(x, y).length():
		var dist when dist > 10:
			return 0
		var dist when dist > 5:
			return 1
		var dist when dist > 1:
			return 5
		_:
			return 10