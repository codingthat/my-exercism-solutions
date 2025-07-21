@export var position : Vector2i
@export var direction : String
var directions = ["north", "east", "south", "west"]

func move(instructions: String):
	for i in len(instructions):
		var cur = instructions[i]
		if cur == "R":
			direction = directions[(directions.find(direction) + 1) % 4]
		elif cur == "L":
			direction = directions[(directions.find(direction) - 1) % 4]
		else:
			if direction == "north":
				position.y += 1
			elif direction == "east":
				position.x += 1
			elif direction == "south":
				position.y -= 1
			else:
				position.x -= 1
	
