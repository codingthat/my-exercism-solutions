@export var card_num : String


func valid():
	var sum = 0
	var count = 0
	for i in range(len(card_num)-1, -1, -1):
		if card_num[i].is_valid_int():
			count += 1
			var digit = card_num[i].to_int()
			if count % 2 == 0:
				digit *= 2
				if digit > 9:
					digit -= 9
			sum += digit
		elif card_num[i] != " ":
			return false
	if count < 2:
		return false
	return sum % 10 == 0