func on_planet(planet, seconds):
    const day_lengths = {
        "Mercury": 0.2408467,
        "Venus": 0.61519726,
        "Earth": 1.0,
        "Mars": 1.8808158,
        "Jupiter": 11.862615,
        "Saturn": 29.447498,
        "Uranus": 84.016846,
        "Neptune": 164.79132,
    }
    const earth_day_in_seconds = 31557600
    return seconds / (earth_day_in_seconds * day_lengths[planet])