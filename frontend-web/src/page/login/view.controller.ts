import { useCallback, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { checkIsAgreed, checkIsIdentified } from "@api/auth/users.ts";
import { isAxiosError } from "axios";

export function useLoginPageViewController() {
  const navigate = useNavigate();

  const [isLoading, setIsLoading] = useState<boolean>(false);

  const checkIsIdentifiedCallback = useCallback(() => {
    checkIsIdentified()
      .then((response) => {
        const isIdentified = response.data.data.isIdentified;

        setIsLoading(false);
        if (isIdentified) {
          navigate("/expert");
        } else {
          navigate("/login/identify");
        }
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          navigate("/");
        }
      });
  }, [navigate]);

  const checkIsDoneCallback = useCallback(() => {
    checkIsAgreed()
      .then((isAgreedResponse) => {
        const isAgreed = isAgreedResponse.data.data.isOptionalAgreementAccepted;

        if (isAgreed === null) {
          setIsLoading(false);
          navigate("/login/terms");
        } else {
          checkIsIdentifiedCallback();
        }
      })
      .catch((error) => {
        if (isAxiosError(error)) {
          navigate("/");
        }
      });
  }, [checkIsIdentifiedCallback, navigate]);

  useEffect(() => {
    setIsLoading(true);

    checkIsDoneCallback();
  }, [checkIsDoneCallback, navigate]);

  return { isLoading };
}
