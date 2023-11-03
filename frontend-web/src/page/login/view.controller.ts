import { useCallback, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { checkIsAgreed, checkIsIdentified } from "@api/auth/user/api.ts";
import { isAxiosError } from "axios";
import { logOnDev } from "@util/log-on-dev.ts";

export function useLoginPageViewController() {
  const navigate = useNavigate();

  const [isLoading, setIsLoading] = useState<boolean>(false);

  const redirectToSocialLoginNotYeyPage = useCallback(() => {
    setIsLoading(false);
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

        setIsLoading(false);
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
          setIsLoading(false);
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
    setIsLoading(true);

    checkIsDoneCallback();
  }, [checkIsDoneCallback, navigate]);

  return { isLoading };
}
