import { useCallback } from "react";
import useSnackbar from "../../../hooks/use-snackbar.tsx";
import { useNavigate } from "react-router-dom";

export const useLoginMainPageViewController = () => {
  const { open, onClose, openSnackbar } = useSnackbar();

  const navigate = useNavigate();

  const onKakaoLoginClick = useCallback(async () => {
    navigate("/expert");
    // try {
    //   const response = await getKakaoRedirectUrl();
    //
    //   if (response.status === HttpStatusCode.Ok) {
    //     setOpen(false);
    //     window.location.href = response.data.data.url;
    //   }
    // } catch (error) {
    //   if (isAxiosError(error)) {
    //     openSnackbar();
    //   }
    // }
  }, [navigate]);

  const onGoogleLoginClick = useCallback(async () => {
    navigate("/expert");
    // try {
    //   const response = await getGoogleRedirectUrl();
    //
    //   if (response.status === HttpStatusCode.Ok) {
    //     setOpen(false);
    //     window.location.href = response.data.data.url;
    //   }
    // } catch (error) {
    //   if (isAxiosError(error)) {
    //     openSnackbar();
    //   }
    // }
  }, [navigate]);

  return {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, onClose, openSnackbar },
  };
};
