import { TRedirectUrlResponse } from "./types/redirect-url.ts";
import { noAuthAxios } from "../instance.ts";
import { CommonResponse } from "../../response.ts";
import { AxiosResponse } from "axios";
import { TAccessTokenResponse } from "@api/noauth/auth/types/access-token.ts";

export const getKakaoRedirectUrl = async <T = CommonResponse<TRedirectUrlResponse>>(): Promise<AxiosResponse<T>> => {
  return await noAuthAxios.get<T>(`/auth/kakao`);
};

export const getGoogleRedirectUrl = async <T = CommonResponse<TRedirectUrlResponse>>(): Promise<AxiosResponse<T>> => {
  return await noAuthAxios.get<T>(`/auth/google`);
};

export const reissueToken = async <T = CommonResponse<TAccessTokenResponse>>(): Promise<AxiosResponse<T>> => {
  return await noAuthAxios.post<T>(`/auth/reissue/secure`);
};
