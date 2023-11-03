import { useCallback, useEffect, useState } from "react";
import { logOnDev } from "@util/log-on-dev.ts";
import { useLocation, useNavigate } from "react-router-dom";
import { checkIsIdentified, identify } from "@api/auth/user/api.ts";
import { HttpStatusCode, isAxiosError } from "axios";

type TIdResponse = {
  error_code: string | null;
  error_msg: string | null;
  imp_uid: string;
  merchant_uid: string;
  pg_provider: string;
  pg_type: string;
  success: boolean;
};

export const useIdentifyPageViewController = () => {
  /* Location Params */
  const { state } = useLocation();

  /* Custom Hooks */
  const navigate = useNavigate();

  /* useStates */
  const [isLoading, setIsLoading] = useState<boolean>(false);

  /* Functions */
  const redirectToSocialLoginNotYeyPage = useCallback(() => {
    logOnDev(
      `🚨 [Unauthorized Access] User Is About To Do Identification Without Social Login. Redirect To Failure Page...`,
    );
    navigate("/login/social/not-yet");
    return;
  }, [navigate]);

  const finishIdentification = useCallback(
    (isSuccess: boolean) => {
      setIsLoading(false);
      navigate("/login/identify/result", { state: { isSuccess } });
    },
    [navigate],
  );

  const onIdentificationClick = useCallback(() => {
    setIsLoading(true);

    const IMP = window.IMP;
    IMP.init(`${import.meta.env.VITE_MERCHANDISE_ID}`);

    /* Pop Up Integrated Identification Window */
    IMP.certification(
      {
        pg: "inicis_unified",
        merchant_uid: `mid_${Date.now().toString()}`,
        popup: true,
      },
      async (response: TIdResponse) => {
        logOnDev(`🛬 [Identification Response] ${response}`);

        if (response.success) {
          logOnDev(`🎉 [Identification Request Success]`);

          const sendIdentifyResponse = await identify(response.imp_uid);

          if (sendIdentifyResponse.status === HttpStatusCode.Ok) {
            logOnDev(`🎉 [User Registration Success]`);
            finishIdentification(true);
            return;
          } else {
            finishIdentification(false);
            return;
          }
        } else {
          logOnDev(`🚨 [Identification Failure] ${response.error_code} | ${response.error_msg}`);
          finishIdentification(false);
          return;
        }
      },
    );
  }, [finishIdentification]);

  /* useEffects */
  useEffect(() => {
    setIsLoading(true);

    if (!state?.fromTerms) {
      redirectToSocialLoginNotYeyPage();
      return;
    }

    checkIsIdentified()
      .then((response) => {
        if (response.status === HttpStatusCode.Ok) {
          const isIdentified = response.data.data.isIdentified;

          if (isIdentified) {
            navigate("/expert");
            return;
          }
        } else {
          logOnDev(
            `🤔 [Invalid Http Response Code] Code ${response.status} Is Received But ${HttpStatusCode.Ok} Is Expected.`,
          );
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
  }, [state, navigate, redirectToSocialLoginNotYeyPage]);

  return { onIdentificationClick, isLoading };
};
