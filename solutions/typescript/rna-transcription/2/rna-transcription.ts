export default class Transcriptor {
    static translations = {
        G: 'C',
        C: 'G',
        T: 'A',
        A: 'U',
    }
    toRna(dna: string) {
        return dna.split('').map((value: string) => {
            const nucleotide = Transcriptor.translations[value]
            if (!nucleotide) {
                throw new Error('Invalid input DNA.')
            }
            return nucleotide
        }).join('')
    }
}