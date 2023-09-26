export const logOnDev = (log: any) => {
  if (import.meta.env.MODE === "development") {
    console.log(log);
  }
};
