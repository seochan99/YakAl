import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";
import { EFacilityField } from "@type/facility-field.ts";
import { EOrder } from "@type/order.ts";

export const getFacilityRequestList = async <T = CommonResponse<null>>(
  nameQuery: string,
  sortCrit: EFacilityField,
  order: EOrder,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(
    `/admin/medical/register/request?name={}&sort={date|name|type|mname}&order={desc|asc}&num={}`,
  );
};
