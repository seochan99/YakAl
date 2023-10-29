import { PatientPageViewModel } from "../../view.model.ts";

export const useGeriatricSyndromeViewController = () => {
  const { patientInfo } = PatientPageViewModel.getStates();

  return { geriatricSyndrome: patientInfo.geriatricSyndrome };
};
