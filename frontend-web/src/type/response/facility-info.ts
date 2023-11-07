import { EFacilityType } from "@type/enum/facility-type.ts";

export type TFacilityInfo = {
  type: EFacilityType;
  chiefName: string;
  chiefTel: string;
  facilityName: string;
  facilityNumber: string;
  zipCode: string;
  address: string;
  businessRegiNumber: string;
  tel: string | null;
  clinicHours: string | null;
  features: string | null;
};

export type TAdminFacilityDetail = {
  type: EFacilityType;
  chiefName: string;
  chiefTel: string;
  facilityName: string;
  facilityNumber: string;
  zipCode: string;
  address: string;
  businessRegiNumber: string;
  certificateImg: string;
  tel: string | null;
  clinicHours: string | null;
  features: string | null;
  requestedAt: number[];
};
