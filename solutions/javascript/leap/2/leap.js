export default function isLeapYear(year) {
    const intYear = parseInt(year, 10);
    if (isNaN(intYear)) { throw new Error("Must provide the year as a number"); }
    if (intYear % 400 === 0) { return true; }
    if (intYear % 4 !== 0 || intYear % 100 === 0 ) { return false; }
    return true;
}