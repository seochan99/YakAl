import { useLocation, useNavigate } from "react-router-dom";
import { useEffect } from "react";

export function useIdentifyResultPageViewController() {
  const location = useLocation();

  const navigate = useNavigate();

  useEffect(() => {
    if (!location.state?.isSuccess) {
      navigate("/");
      return;
    }
  }, [navigate, location]);

  return { isSuccess: location.state?.isSuccess };
}
