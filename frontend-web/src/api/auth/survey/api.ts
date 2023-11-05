import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";

export const getGeriatricSyndrome = async <T = CommonResponse<null>>(patientId: number): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/survey/senior`);
};
