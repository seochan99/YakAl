import { useCallback } from "react";
import { PatientPageViewModel } from "../../view.model.ts";
import { usePathId } from "@hooks/use-path-id.ts";

export const useMedicationViewController = () => {
  const { getStates } = PatientPageViewModel;
  const {
    patientInfo: { medication },
    isLoading,
  } = getStates();

  const patientId = usePathId();

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
