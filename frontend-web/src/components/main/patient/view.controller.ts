import { useLocation } from "react-router-dom";
import { PatientPageViewModel } from "./view.model.ts";
import { useCallback, useEffect } from "react";
import { EPatientInfoTab } from "@type/patient-info-tab.ts";

export const usePatientPageViewController = () => {
  PatientPageViewModel.use();

  const { isLoading, patientInfo, currentTab, tabInfos } = PatientPageViewModel.getStates();

  const location = useLocation();
  const lastSlashIndex = location.pathname.lastIndexOf("/");
  const patientId = +location.pathname.substring(lastSlashIndex + 1);

  useEffect(() => {
    PatientPageViewModel.fetchBase(patientId);
    PatientPageViewModel.fetchProtector(patientId);
    PatientPageViewModel.fetchLastETC(patientId);
    PatientPageViewModel.fetchGeriatricSyndrome(patientId);
    PatientPageViewModel.fetchScreening(patientId);
    PatientPageViewModel.fetchScreening(patientId);
    PatientPageViewModel.fetchETC(patientId);
    PatientPageViewModel.fetchARMS(patientId);
    PatientPageViewModel.fetchBeersList(patientId);
    PatientPageViewModel.fetchAnticholinergic(patientId);
  }, [patientId]);

  const onClickTab = useCallback(
    (selectedTab: EPatientInfoTab) => () => {
      PatientPageViewModel.setCurrentTab(selectedTab);
    },
    [],
  );

  return { isLoading, patientInfo, tab: { currentTab, tabInfos, onClickTab } };
};
