import { useCallback, useEffect, useState } from "react";
import { Cookies } from "react-cookie";
import { logOnDev } from "@util/log-on-dev.ts";
import { useNavigate } from "react-router-dom";
import { checkIsAgreed, setIsOptionalAgreementAccepted } from "@api/auth/user/api.ts";
import { isAxiosError } from "axios";

export function useTermsPageViewController() {
  /* React States */
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [snackbarOpen, setSnackbarOpen] = useState<boolean>(false);
  const [isAgreed, setIsAgreed] = useState<boolean>(false);

  /* Custom Hooks */
  const navigate = useNavigate();

  /* Functions */
  const redirectToSocialLoginNotYeyPage = useCallback(() => {
    logOnDev(
      `🚨 [Unauthorized Access] User Is About To Do Identification Without Social Login. Redirect To Failure Page...`,
    );
    navigate("/login/social/not-yet");
    return;
  }, [navigate]);

  const onClickIsAgreed = useCallback(() => {
    setIsAgreed(!isAgreed);
  }, [isAgreed]);

  const onClickNextButton = useCallback(() => {
    setIsOptionalAgreementAccepted(true)
      .then(() => {
        navigate("/login/identify", { state: { fromTerms: true } });
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          setSnackbarOpen(true);
        }
      });
  }, [navigate]);

  /* useEffects */
  useEffect(() => {
    setIsLoading(true);

    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken || accessToken === "") {
      redirectToSocialLoginNotYeyPage();
      return;
    }

    cookies.remove("accessToken", { path: "/" });

    checkIsAgreed()
      .then((response) => {
        const isAgreed = response.data.data.isOptionalAgreementAccepted;

        if (isAgreed !== null) {
          navigate("/login/identify", { state: { fromTerms: true } });
          return;
        }
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          redirectToSocialLoginNotYeyPage();
          return;
        }
      })
      .finally(() => {
        setIsLoading(false);
      });
  }, [navigate, redirectToSocialLoginNotYeyPage]);

  return { isAgreed, onClickIsAgreed, onClickNextButton, snackbarOpen, setSnackbarOpen, isLoading };
}
