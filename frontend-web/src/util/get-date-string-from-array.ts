export function getDateStringFromArray(date: number[]): string {
  if (date.length < 3) {
    return "XXXX. XX. XX.";
  }

  return `${date[0]}. ${date[1] < 10 ? "0".concat(date[1].toString()) : date[1]}. ${
    date[2] < 10 ? "0".concat(date[2].toString()) : date[2]
  }.`;
}
