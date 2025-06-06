class Gigasecond {
    constructor(birth) {
        this.birth = birth;
    }
    date() {
        return new Date(this.birth*1 + Math.pow(10, 12));
    }
}

export default Gigasecond;