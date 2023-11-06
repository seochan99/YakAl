import { CommonResponse } from "../response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "./instance.ts";
import { TImpUidRequest } from "@type/response/imp-uid.ts";
import { TCheckIsIdentified } from "@type/response/check-is-identified.ts";
import { TIsAgreed } from "@type/response/is-agreed.ts";

export const identify = async <T = CommonResponse<null>>(impUid: string): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>, TImpUidRequest>(`/users/identify`, {
    impUid: impUid,
  });
};

export const checkIsIdentified = async <T = CommonResponse<TCheckIsIdentified>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/users/check/identification`);
};

export const checkIsAgreed = async <T = CommonResponse<TIsAgreed>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/users/optional-agreement`);
};

export const setIsOptionalAgreementAccepted = async <T = CommonResponse<TIsAgreed>>(
  isAgreed: boolean,
): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>, TIsAgreed>(`/users/optional-agreement`, {
    isOptionalAgreementAccepted: isAgreed,
  });
};
