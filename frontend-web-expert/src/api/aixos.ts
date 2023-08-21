import axios, { Axios } from "axios";

// Global Axios Config
export const client: Axios = axios.create({
  baseURL: import.meta.env.VITE_DEV_SERVER_HOST,
  headers: {
    "Content-Type": "application/json",
  },
  withCredentials: true,
});

// Global Axios Logger Interceptors
client.interceptors.request.use(
  (config) => {
    console.log("Request Config: ", config);
    return config;
  },
  (error) => {
    console.log("Request Error: ", error);
    return Promise.reject(error);
  },
);

client.interceptors.response.use(
  (response) => {
    console.log("Response Recieved: ", response);
    return response;
  },
  (error) => {
    console.log("Response Error: ", error);
    return Promise.reject(error);
  },
);
