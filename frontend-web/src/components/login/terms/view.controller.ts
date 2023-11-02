import { useCallback, useEffect, useState } from "react";
import { Cookies } from "react-cookie";
import { logOnDev } from "@util/log-on-dev.ts";
import { useNavigate } from "react-router-dom";

export function useTermsPageViewController() {
  /* React States */
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
    navigate("/login/identify", { state: { fromTerms: true } });
  }, [navigate]);

  /* useEffects */
  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken || accessToken === "") {
      redirectToSocialLoginNotYeyPage();
      return;
    }

    cookies.remove("accessToken", { path: "/" });
  }, [redirectToSocialLoginNotYeyPage]);

  return { isAgreed, onClickIsAgreed, onClickNextButton };
}
