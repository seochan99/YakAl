import { useCallback, useState } from "react";
import { getGoogleRedirectUrl, getKakaoRedirectUrl } from "@api/noauth/auth.ts";
import { isAxiosError } from "axios";

export const useLoginMainPageViewController = () => {
  const [open, setOpen] = useState<boolean>(false);

  const onKakaoLoginClick = useCallback(async () => {
    try {
      const response = await getKakaoRedirectUrl();
      window.location.href = response.data.data.url;
    } catch (error) {
      if (isAxiosError(error)) {
        setOpen(true);
      }
    }
  }, [setOpen]);

  const onGoogleLoginClick = useCallback(async () => {
    try {
      const response = await getGoogleRedirectUrl();
      window.location.href = response.data.data.url;
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
