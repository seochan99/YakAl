import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ExpertUserModel } from "@store/expert-user.ts";

export function useLoginPageViewController() {
  const navigate = useNavigate();

  const [isLoading, setIsLoading] = useState<boolean>(false);

  useEffect(() => {
    setIsLoading(true);

    ExpertUserModel.getInstance()
      .fetchAndRedirect(navigate)
      .finally(() => {
        setIsLoading(false);
      });
  }, [navigate]);

  return { isLoading };
}
