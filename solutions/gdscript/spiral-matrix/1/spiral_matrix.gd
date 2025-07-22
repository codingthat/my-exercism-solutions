func spiral_matrix(size):
	if size == 0:
		return []
	var row = []
	row.resize(size)
	row.fill(0)
	var matrix = [row]
	for i in range(size - 1):
		matrix.append(row.duplicate())
	
	var top = 0
	var bottom = size
	var left = 0
	var right = size
	var n = 1
	while top < bottom and left < right:
		for i in range(left, right):
			matrix[top][i] = n
			n += 1
		top += 1
		for i in range(top, bottom):
			matrix[i][right - 1] = n
			n += 1
		right -= 1
		if top < bottom:
			for i in range(right - 1, left - 1, -1):
				matrix[bottom - 1][i] = n
				n += 1
			bottom -= 1
		if left < right:
			for i in range(bottom - 1, top - 1, -1):
				matrix[i][left] = n
				n += 1
			left += 1
	return matrix