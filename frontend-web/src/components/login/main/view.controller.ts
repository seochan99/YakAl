import { useCallback, useState } from "react";

export const useLoginMainPageViewController = () => {
  const [open, setOpen] = useState<boolean>(false);

  const onKakaoLoginClick = useCallback(async () => {
    window.location.href = `${import.meta.env.VITE_SERVER_HOST_WITHOUT_API}/oauth2/authorization/kakao`;
  }, []);

  const onGoogleLoginClick = useCallback(async () => {
    window.location.href = `${import.meta.env.VITE_SERVER_HOST_WITHOUT_API}/oauth2/authorization/google`;
  }, []);

  return {
    onKakaoLoginClick,
    onGoogleLoginClick,
    snackbarController: { open, setOpen },
  };
};
