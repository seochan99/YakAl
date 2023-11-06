import { TAdminExpertItem } from "@type/response/admin-expert-item.ts";

export type TAdminExpertList = {
  datalist: TAdminExpertItem[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};
