import { CommonResponse } from "@api/response.ts";
import { AxiosResponse } from "axios";
import { authAxios } from "@api/auth/instance.ts";
import { EFacilityField } from "@type/enum/facility-field.ts";
import { EOrder } from "@type/enum/order.ts";
import { TFacilityListSortType } from "@store/admin-facility-list.ts";
import { TAdminFacilityList } from "@type/response/admin-facility-list.ts";
import { TAdminExpertList } from "@type/response/admin-expert-list.ts";
import { TExpertListSort } from "@store/admin-expert-list.ts";
import { EExpertField } from "@type/enum/expert-field.ts";
import { TAdminFacilityDetail } from "@type/response/facility-info.ts";
import { TExpertDetail } from "@store/admin-expert-detail.ts";
import { TApproveExpertRequest } from "@type/request/approve-expert-request.ts";
import { EJob } from "@type/enum/job.ts";
import { TApprovalFacilityRequest } from "@type/request/approval-facility-request.ts";

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
    `/admins/medical-establishments?name=${nameQuery}&sort=${sortCrit}&order=${
      sortBy.order === EOrder.DESC ? "desc" : "asc"
    }&num=${pageNum}`,
  );
};

export const getFacilityInfo = async <T = CommonResponse<TAdminFacilityDetail>>(
  medicalEstablishmentID: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/admins/medical-establishments/${medicalEstablishmentID}`);
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
    `/admins/expert-certifications?name=${nameQuery}&sort=${sortCrit}&order=${
      sortBy.order === EOrder.DESC ? "desc" : "asc"
    }&num=${pageNum}`,
  );
};

export const getExpertInfo = async <T = CommonResponse<TExpertDetail>>(
  expertCertificationID: number,
): Promise<AxiosResponse<T>> => {
  return await authAxios.get<T, AxiosResponse<T>>(`/admins/expert-certifications/${expertCertificationID}`);
};

export const approveExpert = async <T = CommonResponse<null>>(
  expertCertificationID: number,
  isApproval: boolean,
  department: string,
  job: EJob,
): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>, TApproveExpertRequest>(
    `/admins/expert-certifications/${expertCertificationID}`,
    {
      isApproval,
      department,
      job,
    },
  );
};

export const approveFacility = async <T = CommonResponse<null>>(
  medicalEstablishmentID: number,
  isApproval: boolean,
): Promise<AxiosResponse<T>> => {
  return await authAxios.patch<T, AxiosResponse<T>, TApprovalFacilityRequest>(
    `/admins/medical-establishments/${medicalEstablishmentID}`,
    {
      isApproval,
    },
  );
};
