import React, { useState } from "react";
import { AdminExpertDetailModel } from "@store/admin-expert-detail.ts";

export class AdminExpertDetailViewModel {
  private static updater = false;
  private static setState: React.Dispatch<React.SetStateAction<boolean>>;

  private static adminExpertDetailModel = AdminExpertDetailModel.getInstance();

  private static flush = () => {
    if (this.setState === undefined) {
      return;
    }
    this.setState(!this.updater);
  };

  public static use = () => {
    [this.updater, this.setState] = useState<boolean>(false);
  };

  public static fetch = async (expertId: number) => {
    this.adminExpertDetailModel.invalidate();
    this.flush();
    await this.adminExpertDetailModel.fetch(expertId);
    this.flush();
  };

  public static getState = () => {
    return {
      expertDetail: this.adminExpertDetailModel.getExpertDetail(),
      isLoading: this.adminExpertDetailModel.isLoading(),
    };
  };
}
