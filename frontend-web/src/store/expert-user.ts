import { TExpertUser } from "@api/auth/experts/types/expert-user.ts";
import { getExpertUserInfo } from "@api/auth/experts/api.ts";
import { HttpStatusCode } from "axios";
import { logOnDev } from "@util/log-on-dev.ts";
import { NavigateFunction } from "react-router-dom";

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
    getExpertUserInfo()
      .then((response) => {
        if (response.status === HttpStatusCode.Ok) {
          this.expertUser = response.data.data;
        } else {
          logOnDev(
            `🤔 [Invalid Http Response Code] Code ${response.status} Is Received But ${HttpStatusCode.Ok} Is Expected.`,
          );
        }
      })
      .catch(() => {
        this.invalidate();
        window.location.replace("/");
      });
  };

  public fetchAndRedirect = async (navigate: NavigateFunction) => {
    getExpertUserInfo()
      .then((response) => {
        if (response.status === HttpStatusCode.Ok) {
          this.expertUser = response.data.data;
          navigate("/expert");
        } else {
          logOnDev(
            `🤔 [Invalid Http Response Code] Code ${response.status} Is Received But ${HttpStatusCode.Ok} Is Expected.`,
          );
        }
      })
      .catch(() => {
        this.invalidate();
        navigate("/");
      });
  };

  public invalidate = () => {
    this.expertUser = null;
  };

  public isLoading = () => this.expertUser == null;

  public getExpertUser = () => this.expertUser;
}
