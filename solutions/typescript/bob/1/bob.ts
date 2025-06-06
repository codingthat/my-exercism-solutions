export default class Bob {
    hey(stimulus: string) {
        if (stimulus.trim() === '') { return 'Fine. Be that way!' }
        if (stimulus.toUpperCase() === stimulus
         && stimulus.toLowerCase() !== stimulus) {
            return 'Whoa, chill out!'
        }
        if (stimulus.slice(-1) === '?') { return 'Sure.' }
        return 'Whatever.'
    }
}