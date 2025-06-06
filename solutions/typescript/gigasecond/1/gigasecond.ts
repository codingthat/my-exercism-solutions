const MS_PER_GIGASECOND: number = Math.pow(10, 12)
export default class Gigasecond {
    cache: Date
    constructor(birth: Date) {
        this.cache = new Date(birth * 1 + MS_PER_GIGASECOND)
    }
    date() { return this.cache }
}