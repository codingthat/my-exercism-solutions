export default class Pangram {
    constructor(sentence) {
        this.lettersUsed = sentence.toLowerCase().split('').reduce((bitmask, letter) => {
            const letterVal = letter.charCodeAt(0) - 97;
            if (letterVal < 0 || letterVal > 25) { return bitmask; }
            return bitmask | 1 << letterVal;
        }, 0);
    }
    isPangram() {
        return this.lettersUsed === (1 << 26) - 1; // 26 1's means we covered the alphabet
    }
}