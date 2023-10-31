import { PatientModel } from "@store/patient.ts";
import { useCallback, useEffect } from "react";
import { useLocation } from "react-router-dom";
import { PatientPageViewModel } from "../../view.model.ts";

export const useMedicationViewController = () => {
  const { medication } = PatientModel.getPatientInfo();

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
      PatientPageViewModel.setETCPage(page, patientId);
    },
    [patientId],
  );

  const onChangeBeersListPage = useCallback(
    (page: number) => {
      PatientPageViewModel.setBeersListPage(page, patientId);
    },
    [patientId],
  );

  const onChangeAnticholinergicDrugsPage = useCallback(
    (page: number) => {
      PatientPageViewModel.setAnticholinergicDrugsPage(page, patientId);
    },
    [patientId],
  );

  return { medication, paging: { onChangeETCPage, onChangeBeersListPage, onChangeAnticholinergicDrugsPage } };
};
