import { useNavigate } from "react-router-dom";
import { useCallback, useEffect } from "react";
import { logOnDev } from "@util/log-on-dev.ts";
import { Cookies } from "react-cookie";
import { authAxios } from "@api/auth/instance.ts";
import { checkIsAgreed, checkIsIdentified } from "@api/auth/user/api.ts";
import { isAxiosError } from "axios";

export function useLoginProcessJunctionViewController() {
  const navigate = useNavigate();

  const redirectToSocialLoginNotYeyPage = useCallback(() => {
    logOnDev(
      `🚨 [Unauthorized Access] User Is About To Do Identification Without Social Login. Redirect To Failure Page...`,
    );
    navigate("/login/social/not-yet");
    return;
  }, [navigate]);

  const checkIsIdentifiedCallback = useCallback(() => {
    checkIsIdentified()
      .then((response) => {
        const isIdentified = response.data.data.isIdentified;

        if (isIdentified) {
          navigate("/expert");
        } else {
          navigate("/login/identify");
        }
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          redirectToSocialLoginNotYeyPage();
        }
      });
  }, [navigate, redirectToSocialLoginNotYeyPage]);

  const checkIsDoneCallback = useCallback(() => {
    checkIsAgreed()
      .then((isAgreedResponse) => {
        const isAgreed = isAgreedResponse.data.data.isOptionalAgreementAccepted;

        if (isAgreed === null) {
          navigate("/login/terms");
        } else {
          checkIsIdentifiedCallback();
        }
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          redirectToSocialLoginNotYeyPage();
        }
      });
  }, [checkIsIdentifiedCallback, navigate, redirectToSocialLoginNotYeyPage]);

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken) {
      logOnDev(`🚨 [Social Login Failed] Social Login Was Done But Access Token Was Lost. Redirect To Failure Page...`);
      navigate("/login/social/failure");
      return;
    }

    logOnDev(`🔐 [Social Login Success] Social Login Is Successfully Done.`);
    logOnDev(`🔑 [Access Token Received] ${accessToken}`);

    authAxios.defaults.headers.common["Authorization"] = `Bearer ${accessToken}`;
    cookies.remove("accessToken", { path: "/" });

    checkIsDoneCallback();
  }, [checkIsDoneCallback, navigate, redirectToSocialLoginNotYeyPage]);
}
