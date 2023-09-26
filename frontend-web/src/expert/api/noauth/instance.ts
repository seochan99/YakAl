import axios from "axios";

export const noAuthAxios = axios.create({
  baseURL: import.meta.env.VITE_SERVER_HOST,
});
