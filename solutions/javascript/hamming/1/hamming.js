class Hamming {
    compute(a, b) {
        if (a.length !== b.length) { throw new Error("DNA strands must be of equal length."); }
        return a.split('').filter((codon, index) => codon !== b[index]).length;
    }
}
export default Hamming;