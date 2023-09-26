import { getGoogleRedirectUrl, getKakaoRedirectUrl } from "../../../../api/noauth/auth/api.ts";
import { HttpStatusCode, isAxiosError } from "axios";
import { useCallback } from "react";
import useSnackbar from "../../../../hooks/use-snackbar.tsx";

export const useLoginMainPageViewController = () => {
  const { open, setOpen, onClose, openSnackbar } = useSnackbar();

  const onKakaoLoginClick = useCallback(async () => {
    try {
      const response = await getKakaoRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        setOpen(false);
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        openSnackbar();
      }
    }
  }, [setOpen, openSnackbar]);

  const onGoogleLoginClick = useCallback(async () => {
    try {
      const response = await getGoogleRedirectUrl();

      if (response.status === HttpStatusCode.Ok) {
        setOpen(false);
        window.location.href = response.data.data.url;
      }
    } catch (error) {
      if (isAxiosError(error)) {
        openSnackbar();
      }
    }
  }, [setOpen, openSnackbar]);

  return {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, onClose, openSnackbar },
  };
};
