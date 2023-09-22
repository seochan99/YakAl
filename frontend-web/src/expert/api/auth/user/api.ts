import { CommonResponse } from "../../response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "../instance.ts";
import { TImpUidRequest } from "./types/imp-uid.ts";

export const identify = async <T = CommonResponse<null>>(impUid: string): Promise<AxiosResponse<T>> => {
  return await authAxios.post<T, AxiosResponse<T>, TImpUidRequest>(`/user/identify`, {
    impUid: impUid,
  });
};
