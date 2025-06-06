export default class Transcriptor {
    toRna(dna: string) {
        return dna.split('').map((value: string) => {
            if (value === 'G') { return 'C' }
            if (value === 'C') { return 'G' }
            if (value === 'T') { return 'A' }
            if (value === 'A') { return 'U' }
            throw new Error('Invalid input DNA.')
        }).join('')
    }
}