export default class Words {
    count(phrase) {
        return phrase.toLowerCase().split(/[ \t\n]+/).reduce((acc, val) => {
            if (val === '') { return acc; }
            if (isNaN(acc[val])) { acc[val] = 1; }
            else { acc[val]++; }
            return acc;
        }, {});
    }
}