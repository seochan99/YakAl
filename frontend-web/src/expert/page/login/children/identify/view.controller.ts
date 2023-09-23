import { useCallback, useState } from "react";
import { Cookies } from "react-cookie";
import { logOnDev } from "../../../../util/log-on-dev.ts";
import { useNavigate } from "react-router-dom";
import { identify } from "../../../../api/auth/user/api.ts";
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
  const naviagte = useNavigate();

  const [identifyStart, setIdentifyStart] = useState<boolean>(false);

  const onIdentifyClick = useCallback(() => {
    setIdentifyStart(true);

    const cookies = new Cookies();

    if (!cookies.get("accessToken") || cookies.get("accessToken") === "") {
      naviagte("/expert/login/social/not-yet");
      return;
    }

    cookies.remove("accessToken", { path: "/" });

    const IMP = window.IMP;
    IMP.init(`${import.meta.env.VITE_MERCHANDISE_ID}`);

    /* Pop Up Integrated Identification Window */
    IMP.certification(
      {
        merchant_uid: `mid_${Date.now().toString()}`,
        popup: true,
      },
      async (response: TIdResponse) => {
        logOnDev(`🛬 [Identification Response] ${response}`);
        if (response.success) {
          logOnDev(`🎉 [Identification Success]`);
          const sendIdentifyResponse = await identify(response.imp_uid);

          if (sendIdentifyResponse.status === HttpStatusCode.Ok) {
            naviagte("/expert/login/identify/success");
            return;
          } else {
            naviagte("/expert/login/identify/failure");
            return;
          }
        } else {
          logOnDev(`🚨 [Identification Failure] ${response.error_code} | ${response.error_msg}`);
          /* Identification Failure Logic */
          naviagte("/expert/login/identify/failure");
          return;
        }
      },
    );
  }, [setIdentifyStart, naviagte]);

  return { identifyStart, onIdentificationClick: onIdentifyClick };
};
