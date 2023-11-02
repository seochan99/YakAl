import axios, { AxiosError, AxiosResponse, HttpStatusCode, InternalAxiosRequestConfig } from "axios";
import { logOnDev } from "@util/log-on-dev.ts";
import { redirect } from "react-router-dom";
import { reissueToken } from "@api/noauth/auth/api.ts";

export const authAxios = axios.create({
  baseURL: import.meta.env.VITE_SERVER_HOST,
  withCredentials: true,
});

authAxios.defaults.headers.common[
  "Authorization"
] = `Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1aWQiOiI0Iiwicm9sIjoiUk9MRV9XRUIiLCJpYXQiOjE2OTg3OTg0MjAsImV4cCI6MTY5ODgwMjAyMH0.4hL1dmxudHXluebgk8GbP6MxH0x_nIHFESSht7Msc4oQpOtzkYq8LFjdi0Ki1ntr6y_fd3KIXxMv2_qTSzlDjg`;

authAxios.interceptors.request.use(
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

authAxios.interceptors.response.use(
  (response: AxiosResponse): AxiosResponse => {
    /* Logging */
    const {
      status,
      config: { method, url },
    } = response;

    logOnDev(`🎉 [${method?.toUpperCase()}] ${url} | SUCCESS (${status})`);
    return response;
  },
  async (error: Error | AxiosError): Promise<AxiosError> => {
    if (axios.isAxiosError(error) && error.response && error.config) {
      /* Logging */
      const { statusText, status } = error.response;
      const { method, url } = error.config;
      logOnDev(`🚨 [${method?.toUpperCase()}] ${url} | ${statusText} ${status}`);

      const originalRequest = error.config as InternalAxiosRequestConfig;

      if (error.response.status === HttpStatusCode.Forbidden || error.response.status === HttpStatusCode.Unauthorized) {
        /* Reissue Token */
        logOnDev(`♻️ [${method?.toUpperCase()}] ${url}`);

        const accessTokenResponse = await reissueToken();

        if (accessTokenResponse.status === HttpStatusCode.Created) {
          axios.defaults.headers.common["Authorization"] = `Bearer ${accessTokenResponse.data.data.accessToken}`;
          return axios(originalRequest);
        } else {
          redirect("/");
        }
      }
    } else {
      /* Logging */
      logOnDev(`🚨 ${error.message}`);
    }
    return Promise.reject(error);
  },
);
