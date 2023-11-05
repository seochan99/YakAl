import { useCallback, useEffect } from "react";
import { useLocation } from "react-router-dom";
import { PatientPageViewModel } from "../../view.model.ts";

export const useMedicationViewController = () => {
  const { getStates } = PatientPageViewModel;
  const {
    patientInfo: { medication },
    isLoading,
  } = getStates();

  const location = useLocation();
  const lastSlashIndex = location.pathname.lastIndexOf("/");
  const patientId = +location.pathname.substring(lastSlashIndex + 1);

  useEffect(() => {
    PatientPageViewModel.fetchETC(patientId);
    PatientPageViewModel.fetchARMS(patientId);
    PatientPageViewModel.fetchBeersList(patientId);
    PatientPageViewModel.fetchAnticholinergic(patientId);
  }, [patientId]);

  const onChangeETCPage = useCallback(
    (page: number) => {
      if (medication.etc.page === page) {
        return;
      }
      PatientPageViewModel.setETCPage(page, patientId);
    },
    [medication.etc.page, patientId],
  );

  const onChangeBeersListPage = useCallback(
    (page: number) => {
      if (medication.beersCriteriaMedicines.page === page) {
        return;
      }
      PatientPageViewModel.setBeersListPage(page, patientId);
    },
    [medication.beersCriteriaMedicines.page, patientId],
  );

  const onChangeAnticholinergicDrugsPage = useCallback(
    (page: number) => {
      if (medication.anticholinergicDrugs.page === page) {
        return;
      }
      PatientPageViewModel.setAnticholinergicDrugsPage(page, patientId);
    },
    [medication.anticholinergicDrugs.page, patientId],
  );

  return {
    isLoading,
    medication,
    paging: { onChangeETCPage, onChangeBeersListPage, onChangeAnticholinergicDrugsPage },
  };
};
