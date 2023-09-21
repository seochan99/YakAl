import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from "axios";
import { authAxios } from "./instance.ts";

authAxios.interceptors.request.use(
  (config: InternalAxiosRequestConfig): InternalAxiosRequestConfig => {
    /* Logging */
    const { method, url } = config;
    console.log(`🚀 [${method?.toUpperCase()}] ${url} | START`);
    return config;
  },
  (error: Error | AxiosError): Promise<AxiosError> => {
    /* Logging */
    console.log(`🚨 ${error.message}`);
    return Promise.reject(error);
  },
);

authAxios.interceptors.response.use(
  (response: AxiosResponse): AxiosResponse => {
    /* Logging */
    const {
      status,
      config: { method, url },
    } = response;

    console.log(`🎉 [${method?.toUpperCase()}] ${url} | SUCCESS (${status})`);
    return response;
  },
  (error: Error | AxiosError): Promise<AxiosError> => {
    /* Logging */
    if (axios.isAxiosError(error) && error.response && error.config) {
      const { statusText, status } = error.response;
      const { method, url } = error.config;
      console.log(`🚨 [${method?.toUpperCase()}] ${url?.toUpperCase()} | ${statusText} ${status}`);
    } else {
      console.log(`🚨 ${error.message}`);
    }
    return Promise.reject(error);
  },
);
