import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from "axios";
import { logOnDev } from "@util/log-on-dev.ts";

export const noAuthAxios = axios.create({
  baseURL: import.meta.env.VITE_SERVER_HOST,
  withCredentials: true,
});

noAuthAxios.interceptors.request.use(
  (config: InternalAxiosRequestConfig): InternalAxiosRequestConfig => {
    /* Logging */
    const { method, url } = config;
    logOnDev(`🚀 [${method?.toUpperCase()}] ${url} | START`);
    return config;
  },
  (error: Error | AxiosError): Promise<AxiosError> => {
    /* Logging */
    logOnDev(`🚨 ${error.message}`);
    return Promise.reject(error);
  },
);

noAuthAxios.interceptors.response.use(
  (response: AxiosResponse): AxiosResponse => {
    /* Logging */
    const {
      status,
      config: { method, url },
    } = response;

    logOnDev(`🎉 [${method?.toUpperCase()}] ${url} | SUCCESS (${status})`);
    return response;
  },
  (error: Error | AxiosError): Promise<AxiosError> => {
    /* Logging */
    if (axios.isAxiosError(error) && error.response && error.config) {
      const { statusText, status } = error.response;
      const { method, url } = error.config;
      logOnDev(`🚨 [${method?.toUpperCase()}] ${url?.toUpperCase()} | ${statusText} ${status}`);
    } else {
      logOnDev(`🚨 ${error.message}`);
    }
    return Promise.reject(error);
  },
);
