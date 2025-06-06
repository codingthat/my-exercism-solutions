export default class Hamming {
    compute(a: string, b: string) {
        if (a.length !== b.length) {
            throw new Error('DNA strands must be of equal length.')
        }
        let distance: number = 0
        a.split('').forEach((element, index) => {
            if (element !== b[index]) { distance += 1 }
        })
        return distance
    }
}