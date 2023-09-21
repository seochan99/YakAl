import { getGoogleRedirectUrl, getKakaoRedirectUrl } from "../../../../api/noauth/auth/api.ts";
import { HttpStatusCode, isAxiosError } from "axios";

export class LoginMainPageViewController {
  static onKakaoLoginClick = async () => {
    try {
      const response = await getKakaoRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        console.log(error);
      }
    }
  };

  static onGoogleLoginClick = async () => {
    try {
      const response = await getGoogleRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        console.log(error);
      }
    }
  };
}
