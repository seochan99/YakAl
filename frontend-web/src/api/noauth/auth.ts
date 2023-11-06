import { noAuthAxios } from "./instance.ts";
import { CommonResponse } from "../response.ts";
import { AxiosResponse } from "axios";
import { TAccessTokenResponse } from "@type/response/access-token.ts";

export const reissueToken = async <T = CommonResponse<TAccessTokenResponse>>(): Promise<AxiosResponse<T>> => {
  return await noAuthAxios.post<T>(`/auth/reissue/secure`);
};
