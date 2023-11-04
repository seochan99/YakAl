import { TDoseInfo } from "@api/auth/experts/types/dose-info.ts";

export type TDoseETCInfo = {
  datalist: TDoseInfo[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};
