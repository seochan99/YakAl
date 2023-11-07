import { EJob } from "@type/enum/job.ts";
import { EFacilityType } from "@type/enum/facility-type.ts";
import { getExpertInfo } from "@api/auth/admin.ts";

export type TExpertDetail = {
  belongInfo: {
    type: EFacilityType | string;
    chiefName: string; // "홍길동"
    chiefTel: string; // "01081762322"
    facilityName: string; // "중앙대학교광명병원"
    facilityNumber: string; // "31101445"
    zipCode: string; // "14353"
    address: string; // "경기도 광명시 덕안로 110 (일직동)"
    businessRegiNumber: string; // "819202342"
    tel: string | null; // "1811-7800"
    clinicHours: string | null; // "월요일-토요일 오전 8:30~오후 4:30, 일요일 휴무"
    features: string | null;
  };
  name: string; // "맹약사"
  tel: string; // "010-4141-4141", 해당 전문가 전화번호
  requestedAt: [number, number, number]; // 신청일
  type: EJob | string; // "DOCTOR"
  certificateImg: string; // 자격증 사진
  affiliationImg: string; // 소속 증명 사진
};

export class AdminExpertDetailModel {
  /* PRIVATE MEMBER VARIABLE */
  private expertDetail: TExpertDetail | null = null;

  /* SINGLETON */
  private static instance: AdminExpertDetailModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (AdminExpertDetailModel.instance !== null) {
      return AdminExpertDetailModel.instance;
    }

    AdminExpertDetailModel.instance = new AdminExpertDetailModel();
    return AdminExpertDetailModel.instance;
  };

  /* PUBLIC METHOD */
  public fetch = async (expertId: number) => {
    try {
      const response = await getExpertInfo(expertId);
      this.expertDetail = response.data.data;
    } catch (e) {
      this.expertDetail = null;
    }
  };

  public invalidate = () => {
    this.expertDetail = null;
  };

  public isLoading = () => this.expertDetail === null;

  public getExpertDetail = () => this.expertDetail;
}
