func encode(plain_text):
	return translate(plain_text, 5).trim_suffix(" ")


func decode(ciphered_text):
	return translate(ciphered_text, -1)

func translate(text, group_size):
	var encoded = ""
	var unicode_0 = "0".unicode_at(0)
	var unicode_9 = "9".unicode_at(0)
	var unicode_a = "a".unicode_at(0)
	var unicode_z = "z".unicode_at(0)
	var unicode_A = "A".unicode_at(0)
	var unicode_Z = "Z".unicode_at(0)
	var a_minus_A = unicode_a - unicode_A
	var a_plus_z = "a".unicode_at(0) + "z".unicode_at(0)
	var group_counter = 0
	for i in range(0, text.length()):
		var unicode = text.unicode_at(i)
		if unicode >= unicode_A and unicode <= unicode_Z:
			encoded += String.chr(a_plus_z - unicode - a_minus_A)
			group_counter += 1
		elif unicode >= unicode_a and unicode <= unicode_z:
			encoded += String.chr(a_plus_z - unicode)
			group_counter += 1
		elif unicode >= unicode_0 and unicode <= unicode_9:
			encoded += text[i]
			group_counter += 1
		if group_counter == group_size:
			encoded += " "
			group_counter = 0
	return encoded