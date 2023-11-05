import { TDoseWithRisk } from "@api/auth/experts/types/dose-with-risk.ts";

export type TDoseRiskInfo = {
  datalist: TDoseWithRisk[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};
