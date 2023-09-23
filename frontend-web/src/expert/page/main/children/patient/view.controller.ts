import { useMediaQuery } from "react-responsive";
import { useLocation } from "react-router-dom";

export const usePatientPageViewController = () => {
  const isMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const location = useLocation();
  const lastSlashIndex = location.pathname.lastIndexOf("/");
  const patientId = +location.pathname.substring(lastSlashIndex + 1);

  return { isMobile, patientId };
};
