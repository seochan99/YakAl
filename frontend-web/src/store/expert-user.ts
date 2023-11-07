import { TExpertUser } from "@type/response/expert-user.ts";
import { getExpertUserInfo } from "@api/auth/experts.ts";
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
      const { isOptionalAgreementAccepted, isIdentified, job } = this.expertUser;

      if (isOptionalAgreementAccepted === null) {
        this.invalidate();
        window.location.replace("/login/terms");
        return;
      }

      if (!isIdentified) {
        this.invalidate();
        window.location.replace("/login/identify");
        return;
      }

      if (job === "관리자") {
        if (window.location.pathname !== "/admin") {
          window.location.replace("/admin");
        }
      } else {
        if (window.location.pathname !== "/expert") {
          window.location.replace("/expert");
        }
      }
    } catch (error) {
      if (isAxiosError(error)) {
        this.invalidate();
        if (window.location.pathname !== "/") {
          window.location.replace("/");
        }
      }
    }
  };

  public invalidate = () => {
    this.expertUser = null;
  };

  public isLoading = () => this.expertUser == null;

  public getExpertUser = () => this.expertUser;
}
