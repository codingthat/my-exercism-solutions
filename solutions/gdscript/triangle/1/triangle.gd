func is_equilateral(sides):
	return is_triangle(sides) && (sides[0] == sides[1]) && (sides[1] == sides[2])

func is_isosceles(sides):
	return is_triangle(sides) && ((sides[0] == sides[1]) || (sides[1] == sides[2]) || (sides[0] == sides[2]))

func is_scalene(sides):
	return is_triangle(sides) && (sides[0] != sides[1]) && (sides[1] != sides[2]) && (sides[0] != sides[2])

func is_triangle(sides):
	return (sides[0] * sides[1] * sides[2] > 0) && (sides[0] + sides[1] >= sides[2]) && (sides[1] + sides[2] >= sides[0]) && (sides[0] + sides[2] >= sides[1])