import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";
import { TSortBy } from "@store/patient-list.ts";
import { EPatientField } from "@type/enum/patient-field.ts";
import { EOrder } from "@type/enum/order.ts";
import { TFacilityInfo } from "@type/response/facility-info.ts";
import { EFacilityType } from "@type/enum/facility-type.ts";
import { TExpertUser } from "@type/response/expert-user.ts";
import { TPatientBase } from "@type/response/patient-base.ts";
import { TProtectorInfo } from "@type/response/protector-info.ts";
import { TDoseInfo } from "@type/response/dose-info.ts";
import { TGeriatricSyndromeResult } from "@type/response/geriatric-syndrome-result.ts";
import { TGeneralSurveyResult } from "@type/response/general-survey-result.ts";
import { TDoseETCInfo } from "@type/response/dose-etc-info.ts";
import { TDoseRiskInfo } from "@type/response/dose-etc-with-risk.ts";
import { TApprovedFacilityList } from "@type/response/approved-facility-list.ts";
import { EJob } from "@type/enum/job.ts";

export const getExpertUserInfo = async <T = CommonResponse<TExpertUser>>(): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts`);
};

export const getPatientList = async <T = CommonResponse<null>>(
  sortBy: TSortBy,
  page: number,
  nameQuery: string,
  isOnlyManaged: boolean,
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
    `/experts/patient?${
      nameQuery.length > 0 ? `name=${nameQuery}&` : ""
    }favorite=${isOnlyManaged}&sort=${sortCriteria}&order=${sortBy.order === EOrder.DESC ? "desc" : "asc"}&page=${
      page - 1
    }&num=10`,
  );
};

export const getLatestDoses = async <T = CommonResponse<TDoseInfo[]>>(patientId: number): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/doses`);
};

export const getDoses = async <T = CommonResponse<TDoseETCInfo>>(
  patientId: number,
  page: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/doses/all?page=${page - 1}`);
};

export const getBeersDoses = async <T = CommonResponse<TDoseETCInfo>>(
  patientId: number,
  page: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/doses/beers?page=${page - 1}`);
};

export const getAnticholinergicDoses = async <T = CommonResponse<TDoseRiskInfo>>(
  patientId: number,
  page: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(
    `/experts/patient/${patientId}/doses/anticholinergic?page=${page - 1}`,
  );
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

export const registerExpert = async <T = CommonResponse<null>>(
  type: EJob,
  facilityId: number,
  certificateImg: File,
  affiliationImg: File,
): Promise<AxiosResponse<T>> => {
  const formData = new FormData();

  formData.append(
    "message",
    new Blob(
      [
        JSON.stringify({
          type: type === EJob.DOCTOR ? EFacilityType[EFacilityType.HOSPITAL] : EFacilityType[EFacilityType.PHARMACY],
          facilityId,
        }),
      ],
      { type: "application/json" },
    ),
  );
  formData.append("certificate", certificateImg);
  formData.append("affiliation", affiliationImg);

  return await authAxios.post<T, AxiosResponse<T>>(`/experts/expert-certifications/expert`, formData, {
    headers: { "Content-Type": "multipart/form-data" },
  });
};

export const toggleIsFavorite = async <T = CommonResponse<null>>(patientId: number): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>>(`/experts/medical-appointment/${patientId}`);
};

export const getPatientBaseInfo = async <T = CommonResponse<TPatientBase>>(
  patientId: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}`);
};

export const getProtectorInfo = async <T = CommonResponse<TProtectorInfo>>(
  patientId: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/guardian`);
};

export const getApprovedFacilityList = async <T = CommonResponse<TApprovedFacilityList>>(
  nameQuery: string,
  page: number,
  facilityType: EFacilityType,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(
    `/experts/medical-establishments/search?medical=${EFacilityType[facilityType]}${
      nameQuery.length === 0 ? "" : `&word=${nameQuery}`
    }&page=${page - 1}`,
  );
};

export const getGeriatricSyndromeSurvey = async <T = CommonResponse<TGeriatricSyndromeResult>>(
  patientId: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/survey/senior`);
};

export const getGeneralSurvey = async <T = CommonResponse<TGeneralSurveyResult>>(
  patientId: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/experts/patient/${patientId}/survey/general`);
};
