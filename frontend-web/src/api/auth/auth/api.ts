import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";

export const logout = async <T = CommonResponse<null>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>>(`/auth/logout`);
};
