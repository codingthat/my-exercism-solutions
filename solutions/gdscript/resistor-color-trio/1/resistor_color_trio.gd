func color_code(colors):
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

    var ohms = (mapping[colors[0]] * 10 + mapping[colors[1]]) * 10 ** mapping[colors[2]]

    var kilolevel = 0
    while (ohms > 1000 and ohms % 1000 == 0):
        kilolevel += 1
        ohms = ohms / 1000
    
    return "%s %sohms" % [ohms, prefixes[kilolevel]]
