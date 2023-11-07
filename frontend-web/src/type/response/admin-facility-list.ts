import { TAdminFacilityItem } from "@type/response/admin-facility-item.ts";

export type TAdminFacilityList = {
  datalist: TAdminFacilityItem[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};
