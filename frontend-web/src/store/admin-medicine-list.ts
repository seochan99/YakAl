import { TAdminFacilityItem } from "@type/response/admin-facility-item.ts";

export class AdminMedicineListModel {
  /* PRIVATE MEMBER VARIABLE */
  private facilityList: TAdminFacilityItem[] | null = null;
  //   private totalCount: number | null = null;

  /* SINGLETON */
  private static instance: AdminMedicineListModel | null = null;

  private constructor() {
    return;
  }

  // get facility list instance
  public static getInstance = () => {
    // if instance is not null, return instance
    if (AdminMedicineListModel.instance !== null) {
      return AdminMedicineListModel.instance;
    }
    AdminMedicineListModel.instance = new AdminMedicineListModel();
    return AdminMedicineListModel.instance;
  };

  /* PUBLIC METHOD */

  public isLoading = () => this.facilityList == null;

  public getFacilityList = () => this.facilityList;
}
