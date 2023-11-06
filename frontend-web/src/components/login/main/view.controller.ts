import { useCallback, useState } from "react";
import { getGoogleRedirectUrl, getKakaoRedirectUrl } from "@api/noauth/auth.ts";
import { HttpStatusCode, isAxiosError } from "axios";
import { logOnDev } from "@util/log-on-dev.ts";

export const useLoginMainPageViewController = () => {
  const [open, setOpen] = useState<boolean>(false);

  const onKakaoLoginClick = useCallback(async () => {
    try {
      const response = await getKakaoRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      } else {
        logOnDev(
          `🤔 [Invalid Http Response Code] Code ${response.status} Is Received But ${HttpStatusCode.Ok} Is Expected.`,
        );
        setOpen(true);
      }
    } catch (error) {
      if (isAxiosError(error)) {
        setOpen(true);
      }
    }
  }, [setOpen]);

  const onGoogleLoginClick = useCallback(async () => {
    try {
      const response = await getGoogleRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        setOpen(true);
      }
    }
  }, [setOpen]);

  return {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, setOpen },
  };
};
