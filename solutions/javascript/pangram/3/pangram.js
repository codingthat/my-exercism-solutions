const alphabetSize = 26;
export default class Pangram {
    constructor(sentence) {
        this.sentence = sentence;
    }
    isPangram() {
        return alphabetSize === new Set(this.sentence.toLowerCase().match(/[a-z]/g)).size;
    }
}