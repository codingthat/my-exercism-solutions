class PerfectNumbers {
    classify(input) {
        if (input < 1) { return 'Classification is only possible for natural numbers.'; } // just going by tests, but would also check it's an integer...
        const aliquot = this.aliquot(input);
        if (aliquot === input) { return 'perfect'; }
        if (aliquot > input) { return 'abundant'; }
        return 'deficient';
    }
    aliquot(input) {
        let aliquot = 0;
		for (let possibleFactor = 1; possibleFactor < input; possibleFactor++) {
			if (input % possibleFactor === 0) {
				aliquot += possibleFactor;
			}
		}
        return aliquot;
    }
}
export default PerfectNumbers;