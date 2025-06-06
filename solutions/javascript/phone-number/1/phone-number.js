export default class PhonejustNumbers {
    constructor (input) {
        this.justNumbers = null; // default
        if (input.match(/[a-z]/)) {
            return;
        }
        let justNumbers = input.replace(/[^0-9]/g, '');
        if (justNumbers.length === 11 && justNumbers[0] === '1') {
            this.justNumbers = justNumbers.substr(1);
            return;
        }
        if (justNumbers.length === 10) {
            this.justNumbers = justNumbers;
        }
    }
    number() {
        return this.justNumbers;
    }
}