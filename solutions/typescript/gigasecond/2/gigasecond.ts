const MS_PER_GIGASECOND: number = 10E11
export default class Gigasecond {
    private birth: Date
    constructor (birth: Date) {
        this.birth = birth
    }
    public date = (): Date => new Date(this.birth * 1 + MS_PER_GIGASECOND)
}