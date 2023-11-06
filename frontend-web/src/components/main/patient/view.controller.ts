import { PatientPageViewModel } from "./view.model.ts";
import { useCallback, useEffect } from "react";
import { EPatientInfoTab } from "@type/enum/patient-info-tab.ts";
import { usePathId } from "@hooks/use-path-id.ts";

export const usePatientPageViewController = () => {
  PatientPageViewModel.use();

  const { isLoading, patientInfo, currentTab, tabInfos } = PatientPageViewModel.getStates();

  const patientId = usePathId();

  useEffect(() => {
    PatientPageViewModel.fetchBase(patientId);
    PatientPageViewModel.fetchProtector(patientId);
    PatientPageViewModel.fetchLastETC(patientId);
    PatientPageViewModel.fetchGeriatricSyndrome(patientId);
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
