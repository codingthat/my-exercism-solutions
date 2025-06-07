func color_code(colors):
    var size = colors.size()
    if size == 1:
        return "0 ohms"
    
    const mapping = {
        "black": 0,
        "brown": 1,
        "red": 2,
        "orange": 3,
        "yellow": 4,
        "green": 5,
        "blue": 6,
        "violet": 7,
        "grey": 8,
        "white": 9,
    }
    const prefixes = [
        "",
        "kilo",
        "mega",
        "giga",
    ]
    const tolerances = {
        "grey": 0.05,
        "violet": 0.1,
        "blue": 0.25,
        "green": 0.5,
        "brown": 1,
        "red": 2,
        "gold": 5,
        "silver": 10,
    }

    var ohms
    var tolerance
    if size == 4:
        ohms = (mapping[colors[0]] * 10 + mapping[colors[1]]) * 10 ** mapping[colors[2]]
        tolerance = tolerances[colors[3]]
    elif size == 5:
        ohms = (mapping[colors[0]] * 100 + mapping[colors[1]] * 10 + mapping[colors[2]]) * 10 ** mapping[colors[3]]
        tolerance = tolerances[colors[4]]

    var kilolevel = 0
    while ohms > 1000:
        kilolevel += 1
        if ohms / 1000.0 == ohms / 1000: # for now, due to differences between Godot 4.2 and Godot 4.4
            ohms = ohms / 1000
        else:
            ohms = ohms / 1000.0
    
    return "%s %sohms ±%s%%" % [ohms, prefixes[kilolevel], tolerance]
