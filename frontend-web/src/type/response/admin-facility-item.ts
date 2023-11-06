import { EFacilityType } from "@type/enum/facility-type.ts";

export type TAdminFacilityItem = {
  id: number;
  name: string;
  directorName: string;
  directorTel: string;
  type: EFacilityType | string;
  requestedAt: number[];
};
