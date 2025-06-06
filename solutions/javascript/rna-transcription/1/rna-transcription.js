const dnaCheck = new RegExp('^[GCAT]+$');
class Transcriptor {
    toRna(dna) {
        if (dnaCheck.exec(dna) === null) { throw new Error("Invalid input DNA."); }
        const translateCodon = (codon) => {
            if (codon === 'G') return 'C';
            if (codon === 'C') return 'G';
            if (codon === 'T') return 'A';
            if (codon === 'A') return 'U';
        }
        return dna.split('').map(translateCodon).join('');
    }
}

export default Transcriptor;