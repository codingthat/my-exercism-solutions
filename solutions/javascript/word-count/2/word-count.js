export default class Words {
    count(phrase) {
        return phrase.trim().toLowerCase().split(/\s+/).reduce((counts, word) => {
            if (counts.hasOwnProperty(word)) { counts[word]++; }
            else { counts[word] = 1; }
            return counts;
        }, {});
    }
}