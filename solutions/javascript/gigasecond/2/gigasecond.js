const MS_PER_GIGASECOND = 10 ** 12;

class Gigasecond {
    constructor(birth) {
        this.birthMs = birth*1; // coerce into ms
    }
    date() {
        return new Date(this.birthMs + MS_PER_GIGASECOND);
    }
}

export default Gigasecond;