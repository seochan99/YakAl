import { CommonResponse } from "../../response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "../instance.ts";
import { TAccessTokenResponse } from "./types/access-token.ts";

export const reissueToken = async <T = CommonResponse<TAccessTokenResponse>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.post<T>(`/auth/reissue/secure`);
};
