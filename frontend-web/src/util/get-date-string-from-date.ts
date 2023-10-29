export function getDateStringFromDate(date: Date): string {
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const dayOfMonth = date.getDate();

  return `${year}. ${month < 10 ? "0".concat(month.toString()) : month}. ${
    dayOfMonth < 10 ? "0".concat(dayOfMonth.toString()) : dayOfMonth
  }.`;
}
