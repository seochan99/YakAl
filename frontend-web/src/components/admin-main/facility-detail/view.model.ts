import React, { useState } from "react";
import { AdminFacilityDetailModel } from "@store/admin-facility-detail.ts";

export class AdminFacilityDetailViewModel {
  private static updater = false;
  private static setState: React.Dispatch<React.SetStateAction<boolean>>;

  private static adminFacilityDetailModel = AdminFacilityDetailModel.getInstance();

  private static flush = () => {
    if (this.setState === undefined) {
      return;
    }
    this.setState(!this.updater);
  };

  public static use = () => {
    [this.updater, this.setState] = useState<boolean>(false);
  };

  public static fetch = async (facilityId: number) => {
    this.adminFacilityDetailModel.invalidate();
    this.flush();
    await this.adminFacilityDetailModel.fetch(facilityId);
    this.flush();
  };

  public static getState = () => {
    return {
      facilityDetail: this.adminFacilityDetailModel.getFacilityDetail(),
      isLoading: this.adminFacilityDetailModel.isLoading(),
    };
  };
}
