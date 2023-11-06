import { useCallback, useState } from "react";
import { useNavigate } from "react-router-dom";
import { setIsOptionalAgreementAccepted } from "@api/auth/users.ts";
import { isAxiosError } from "axios";

export function useTermsPageViewController() {
  /* React States */
  const [snackbarOpen, setSnackbarOpen] = useState<boolean>(false);
  const [isAgreed, setIsAgreed] = useState<boolean>(false);

  /* Custom Hooks */
  const navigate = useNavigate();

  /* Functions */
  const onClickIsAgreed = useCallback(() => {
    setIsAgreed(!isAgreed);
  }, [isAgreed]);

  const onClickNextButton = useCallback(() => {
    setIsOptionalAgreementAccepted(true)
      .then(() => {
        navigate("/login/identify");
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          setSnackbarOpen(true);
        }
      });
  }, [navigate]);

  return { isAgreed, onClickIsAgreed, onClickNextButton, snackbarOpen, setSnackbarOpen };
}
