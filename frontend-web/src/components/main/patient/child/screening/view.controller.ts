import { PatientPageViewModel } from "../../view.model.ts";

export const useScreeningViewController = () => {
  const { patientInfo } = PatientPageViewModel.getStates();

  return { screeningDetail: patientInfo.screeningDetail };
};
