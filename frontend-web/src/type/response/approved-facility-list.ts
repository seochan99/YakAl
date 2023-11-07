import { TApprovedFacilityItem } from "@type/response/approved-facility-item.ts";

export type TApprovedFacilityList = {
  dataList: TApprovedFacilityItem[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};
