const zeroPhrase = "No more";
const wallPhrase = " on the wall";
export default class Beer {
    static standardizeNumber(number) {
        if (number === 0) { return zeroPhrase; }
        return '' + number;
    }
    static bottlePhrase(number) {
        const possibleS = (number === 1) ? '' : 's';
        return this.standardizeNumber(number) + " bottle" + possibleS + " of beer";
    }
    static verse(number) {
        const nextNumber = (number === 0) ? 99 : (number - 1);
        const thisBottlePhrase = this.bottlePhrase(number);
        const nextBottlePhrase = this.bottlePhrase(nextNumber);
        let phrase = thisBottlePhrase + wallPhrase + ", " + thisBottlePhrase.toLowerCase() + ".\n";
        if (number === 0) {
            phrase += "Go to the store and buy some more";
        } else {
            const bottleReference = (number === 1) ? "it" : "one";
            phrase += "Take " + bottleReference + " down and pass it around";
        }
        return phrase + ", " + nextBottlePhrase.toLowerCase() + wallPhrase + ".\n";
    }
    static sing(start = 99, end = 0) {
        return Array.from(Array(start - end + 1).keys()).map(offset => {
            return this.verse(start - offset);
        }).join('\n');
    }
}