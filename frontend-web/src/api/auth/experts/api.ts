import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";
import { TSortBy } from "@store/patient-list.ts";
import { EPatientField } from "@type/patient-field.ts";
import { EOrder } from "@type/order.ts";
import { TFacilityInfo } from "@api/auth/experts/types/facility-info.ts";
import { EFacilityType } from "@type/facility-type.ts";
import { TExpertUser } from "@api/auth/experts/types/expert-user.ts";

export const getExpertUserInfo = async <T = CommonResponse<TExpertUser>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts`);
};

export const getPatientList = async <T = CommonResponse<null>>(
  sortBy: TSortBy,
  page: number,
  nameQuery: string,
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

  if (nameQuery.length > 0) {
    return await authAxios.get<T, AxiosResponse<T>>(
      `/experts/patient/name?name=${nameQuery}&sort=${sortCriteria}&order=${
        sortBy.order === EOrder.DESC ? "desc" : "asc"
      }&page=${page - 1}&num=10`,
    );
  }

  return await authAxios.get<T, AxiosResponse<T>>(
    `/experts/patient?sort=${sortCriteria}&order=${sortBy.order === EOrder.DESC ? "desc" : "asc"}&page=${
      page - 1
    }&num=10`,
  );
};

export const getLatestDoses = async <T = CommonResponse<null>>(patientId: number): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/doses`);
};

export const registerFacility = async <T = CommonResponse<null>>(
  facilityInfo: TFacilityInfo,
  certificateImg: File,
): Promise<AxiosResponse<T>> => {
  const formData = new FormData();

  formData.append(
    "message",
    new Blob(
      [
        JSON.stringify({
          ...facilityInfo,
          type: EFacilityType[facilityInfo.type],
        }),
      ],
      { type: "application/json" },
    ),
  );
  formData.append("file", certificateImg);

  return await authAxios.post<T, AxiosResponse<T>>(`/experts/medical-establishments`, formData, {
    headers: { "Content-Type": "multipart/form-data" },
  });
};

export const toggleIsFavorite = async <T = CommonResponse<null>>(patientId: number): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>>(`/experts/medical-appointment/${patientId}`);
};

export const getProtector = async <T = CommonResponse<null>>(patientId: number): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/guardian`);
};

export const getApprovedFacilityList = async <T = CommonResponse<null>>(
  nameQuery: string,
  page: number,
  facilityType: EFacilityType,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(
    `/experts/medical-establishments/search?eMedical=${EFacilityType[facilityType]}&word=${nameQuery}&page=${page - 1}`,
  );
};
