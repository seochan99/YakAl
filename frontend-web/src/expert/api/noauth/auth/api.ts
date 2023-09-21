import { RedirectUrl } from "./types/redirect-url.ts";
import { noAuthAxios } from "../instance.ts";
import { CommonResponse } from "../../response.ts";
import { AxiosResponse } from "axios";

export const getKakaoRedirectUrl = async <T = CommonResponse<RedirectUrl>>(): Promise<AxiosResponse<T>> => {
  return await noAuthAxios.get<T>(`/auth/kakao`);
};

export const getGoogleRedirectUrl = async <T = CommonResponse<RedirectUrl>>(): Promise<AxiosResponse<T>> => {
  return await noAuthAxios.get<T>(`/auth/google`);
};
