import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";
import { EFacilityField } from "@type/facility-field.ts";
import { EOrder } from "@type/order.ts";
import { TFacilityListSortType } from "@store/admin-facility-list.ts";
import { TAdminFacilityList } from "@type/response/admin-facility-list.ts";
import { TAdminExpertList } from "@type/response/admin-expert-list.ts";
import { TExpertListSort } from "@store/admin-expert-list.ts";
import { EExpertField } from "@type/expert-field.ts";

export const getFacilityRequestList = async <T = CommonResponse<TAdminFacilityList>>(
  nameQuery: string,
  sortBy: TFacilityListSortType,
  pageNum: number,
): Promise<AxiosResponse<T>> => {
  let sortCrit: string;

  switch (sortBy.field) {
    case EFacilityField.REQUESTED_AT:
      sortCrit = "date";
      break;
    case EFacilityField.NAME:
      sortCrit = "mname";
      break;
    case EFacilityField.TYPE:
      sortCrit = "type";
      break;
    case EFacilityField.REPRESENTATIVE:
      sortCrit = "name";
      break;
  }

  return await authAxios.get<T, AxiosResponse<T>>(
    `/admin/medical/register/request?name=${nameQuery}&sort=${sortCrit}&order=${
      sortBy.order === EOrder.DESC ? "desc" : "asc"
    }&num=${pageNum}`,
  );
};

export const getExpertRequestList = async <T = CommonResponse<TAdminExpertList>>(
  nameQuery: string,
  sortBy: TExpertListSort,
  pageNum: number,
): Promise<AxiosResponse<T>> => {
  let sortCrit: string;

  switch (sortBy.field) {
    case EExpertField.NAME:
      sortCrit = "name";
      break;
    case EExpertField.REQUESTED_DATE:
      sortCrit = "date";
      break;
    case EExpertField.BELONG_NAME:
      sortCrit = "medical";
      break;
  }

  return await authAxios.get<T, AxiosResponse<T>>(
    `/admin/expert/register/request?name=${nameQuery}&sort=${sortCrit}&order=${
      sortBy.order === EOrder.DESC ? "desc" : "asc"
    }&num=${pageNum}`,
  );
};
