import { CommonResponse } from "../../response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "../instance.ts";
import { TImpUidRequest } from "./types/imp-uid.ts";
import { TCheckIsIdentified } from "@api/auth/user/types/check-is-identified.ts";

export const identify = async <T = CommonResponse<null>>(impUid: string): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>, TImpUidRequest>(`/user/identify`, {
    impUid: impUid,
  });
};

export const checkIsIdentified = async <T = CommonResponse<TCheckIsIdentified>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>, TImpUidRequest>(`/user/check/identification`);
};
