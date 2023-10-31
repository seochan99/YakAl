import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";
import { TSortBy } from "@store/patient-list.ts";
import { EPatientField } from "@type/patient-field.ts";
import { EOrder } from "@type/order.ts";

export const getPatientList = async <T = CommonResponse<null>>(
  sortBy: TSortBy,
  page: number,
): Promise<AxiosResponse<T>> => {
  let sortCriteria;

  switch (sortBy.field) {
    case EPatientField.BIRTHDAY:
      sortCriteria = "birth";
      break;
    case EPatientField.LAST_QUESTIONNAIRE_DATE:
      sortCriteria = "date";
      break;
    case EPatientField.NAME:
      sortCriteria = "name";
      break;
  }

  return await authAxios.get<T, AxiosResponse<T>>(
    `/experts/patient?sort=${sortCriteria}&order=${sortBy.order === EOrder.DESC ? "desc" : "asc"}&page=${
      page - 1
    }&num=10`,
  );
};
