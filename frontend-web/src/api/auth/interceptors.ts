import axios, { AxiosError, AxiosResponse, HttpStatusCode, InternalAxiosRequestConfig } from "axios";
import { authAxios } from "./instance.ts";
import { logOnDev } from "../../util/log-on-dev.ts";
import { reissueToken } from "./auth/api.ts";
import { redirect } from "react-router-dom";

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

      const originalRequest = error.config as InternalAxiosRequestConfig & { _retry: boolean };
      if (
        (error.response.status === HttpStatusCode.Forbidden || error.response.status === HttpStatusCode.Unauthorized) &&
        !originalRequest._retry
      ) {
        /* Reissue Token */
        logOnDev(`♻️ [${method?.toUpperCase()}] ${url}`);
        originalRequest._retry = true;
        const accessTokenResponse = await reissueToken();

        if (accessTokenResponse.status === HttpStatusCode.Created) {
          authAxios.defaults.headers.common["Authorization"] = `Bearer ${accessTokenResponse.data.data.accessToken}`;
          return authAxios(originalRequest);
        } else {
          redirect("/expert/login");
        }
      }
    } else {
      /* Logging */
      logOnDev(`🚨 ${error.message}`);
    }
    return Promise.reject(error);
  },
);
