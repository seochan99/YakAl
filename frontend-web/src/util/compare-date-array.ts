export function compareDateArray(date1: number[], date2: number[]): number {
  for (let i = 0; i < 3; ++i) {
    if (date1[i] > date2[i]) {
      return 1;
    } else if (date1[i] < date2[i]) {
      return -1;
    }
  }
  return 0;
}
