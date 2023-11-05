import { PatientPageViewModel } from "../../view.model.ts";
import { useEffect } from "react";
import { useLocation } from "react-router-dom";

export const useScreeningViewController = () => {
  const { patientInfo } = PatientPageViewModel.getStates();

  const location = useLocation();
  const lastSlashIndex = location.pathname.lastIndexOf("/");
  const patientId = +location.pathname.substring(lastSlashIndex + 1);

  useEffect(() => {
    PatientPageViewModel.fetchScreening(patientId);
  }, [patientId]);

  return { screeningDetail: patientInfo.screeningDetail };
};
