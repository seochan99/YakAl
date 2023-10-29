import { EFacilityType } from "@type/facility-type.ts";

export type TFacilityDetail = {
  type: EFacilityType;
  chiefName: string; // "홍길동"
  chiefTel: string; // "01081762322"
  facilityName: string; // "중앙대학교광명병원"
  facilityNumber: string; // "31101445"
  zipCode: string; // "14353"
  address: string; // "경기도 광명시 덕안로 110 (일직동)"
  businessRegiNumber: string; // "819202342"
  certificateImg: string;
  tel: string | null; // "1811-7800"
  clinicHours: string | null; // "월요일-토요일 오전 8:30~오후 4:30, 일요일 휴무"
  features: string | null;
  requestedAt: [number, number, number]; // 신청일
};

const facilityDetail: TFacilityDetail = {
  type: EFacilityType.HOSPITAL,
  chiefName: "홍길동",
  chiefTel: "01081762322",
  facilityName: "중앙대학교광명병원",
  facilityNumber: "31101445",
  zipCode: "14353",
  address: "경기도 광명시 덕안로 110 (일직동)",
  businessRegiNumber: "819202342",
  certificateImg: "string",
  tel: "1811-7800",
  clinicHours: "월요일-토요일 오전 8:30~오후 4:30, 일요일 휴무",
  features: null,
  requestedAt: [2023, 9, 10],
};

export class AdminFacilityDetailModel {
  /* PRIVATE MEMBER VARIABLE */
  private facilityDetail: TFacilityDetail | null = null;

  /* SINGLETON */
  private static instance: AdminFacilityDetailModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (AdminFacilityDetailModel.instance !== null) {
      return AdminFacilityDetailModel.instance;
    }

    AdminFacilityDetailModel.instance = new AdminFacilityDetailModel();
    return AdminFacilityDetailModel.instance;
  };

  /* PUBLIC METHOD */
  // public fetch = async (expertId: number) => {
  public fetch = async () => {
    this.facilityDetail = null;

    // Dummy async communication
    this.facilityDetail = facilityDetail;
  };

  public invalidate = () => {
    this.facilityDetail = null;
  };

  public isLoading = () => this.facilityDetail == null;

  public getFacilityDetail = () => this.facilityDetail;
}
