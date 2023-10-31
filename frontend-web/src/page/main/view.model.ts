import React, { useState } from "react";
import { ExpertUserModel } from "@store/expert-user.ts";

export class ExpertUserViewModel {
  private static updater = false;
  private static setState: React.Dispatch<React.SetStateAction<boolean>>;

  private static expertUserModel = ExpertUserModel.getInstance();

  private static flush = () => {
    if (this.setState === undefined) {
      return;
    }
    this.setState(!this.updater);
  };

  public static use = () => {
    [this.updater, this.setState] = useState<boolean>(false);
  };

  public static fetch = async () => {
    this.expertUserModel.invalidate();
    this.flush();
    await this.expertUserModel.fetch();
    this.flush();
  };

  public static getExpertUser = () => {
    return this.expertUserModel.getExpertUser();
  };

  public static isLoading = () => {
    return this.expertUserModel.isLoading();
  };
}
