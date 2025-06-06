export default class PerfectNumbers {
    classify(input) {
        if (input < 1) { return 'Classification is only possible for natural numbers.'; } // just going by tests, but would also check it's an integer...
        let aliquot = 0;
        const lastPossibleFactor = input / 2;
		for (let possibleFactor = 1; possibleFactor <= lastPossibleFactor; possibleFactor++) {
			if (input % possibleFactor === 0) {
				aliquot += possibleFactor;
			}
		}
        if (aliquot === input) { return 'perfect'; }
        if (aliquot > input) { return 'abundant'; }
        return 'deficient';
    }
}