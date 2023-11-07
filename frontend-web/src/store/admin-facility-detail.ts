import { getFacilityInfo } from "@api/auth/admin.ts";
import { TAdminFacilityDetail } from "@type/response/facility-info.ts";

export class AdminFacilityDetailModel {
  /* PRIVATE MEMBER VARIABLE */
  private facilityDetail: TAdminFacilityDetail | null = null;

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
  public fetch = async (facilityId: number) => {
    try {
      const response = await getFacilityInfo(facilityId);
      this.facilityDetail = response.data.data;
    } catch (e) {
      this.facilityDetail = null;
    }
  };

  public invalidate = () => {
    this.facilityDetail = null;
  };

  public isLoading = () => this.facilityDetail === null;

  public getFacilityDetail = () => this.facilityDetail;
}
