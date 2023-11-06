import { useCallback, useState } from "react";
import { logOnDev } from "@util/log-on-dev.ts";
import { useNavigate } from "react-router-dom";
import { identify } from "@api/auth/users.ts";
import { HttpStatusCode } from "axios";

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
  /* Custom Hooks */
  const navigate = useNavigate();

  /* useStates */
  const [isLoading, setIsLoading] = useState<boolean>(false);

  /* Functions */
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

  return { onIdentificationClick, isLoading };
};
