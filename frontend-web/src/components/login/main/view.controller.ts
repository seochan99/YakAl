import { useCallback, useState } from "react";
import { useNavigate } from "react-router-dom";

export const useLoginMainPageViewController = () => {
  const [open, setOpen] = useState<boolean>(false);

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
    //     setOpen(true);
    //   }
    // }
  }, [setOpen]);

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
    //     setOpen(true);
    //   }
    // }
  }, [setOpen]);

  return {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, setOpen },
  };
};
