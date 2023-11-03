import { TExpertUser } from "@api/auth/experts/types/expert-user.ts";
import { getExpertUserInfo } from "@api/auth/experts/api.ts";
import { isAxiosError } from "axios";

export class ExpertUserModel {
  /* PRIVATE MEMBER VARIABLE */
  private expertUser: TExpertUser | null = null;

  /* SINGLETON */
  private static instance: ExpertUserModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (ExpertUserModel.instance !== null) {
      return ExpertUserModel.instance;
    }

    ExpertUserModel.instance = new ExpertUserModel();
    return ExpertUserModel.instance;
  };

  /* PUBLIC METHOD */
  public fetch = async () => {
    try {
      const response = await getExpertUserInfo();

      this.expertUser = response.data.data;
      const { isOptionalAgreementAccepted, isIdentified } = this.expertUser;

      if (isOptionalAgreementAccepted === null || !isIdentified) {
        this.invalidate();
        window.location.replace("/");
      }
    } catch (error) {
      if (isAxiosError(error)) {
        this.invalidate();
        window.location.replace("/");
      }
    }
  };

  public invalidate = () => {
    this.expertUser = null;
  };

  public isLoading = () => this.expertUser == null;

  public getExpertUser = () => this.expertUser;
}
