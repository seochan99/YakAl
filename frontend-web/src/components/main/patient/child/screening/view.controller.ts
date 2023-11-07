import { PatientPageViewModel } from "../../view.model.ts";

export const useScreeningViewController = () => {
  const {
    patientInfo: { screeningDetail },
  } = PatientPageViewModel.getStates();

  const totalScore = {
    arms: screeningDetail.arms?.length === 0 ? -1 : screeningDetail.arms?.reduce((sum, current) => sum + current, 0),
    gds:
      screeningDetail.gds?.length === 0
        ? -1
        : screeningDetail.gds?.reduce((sum, current, currentIndex) => {
            if (
              currentIndex === 1 ||
              currentIndex === 6 ||
              currentIndex === 7 ||
              currentIndex === 10 ||
              currentIndex === 11
            ) {
              return sum + (current ? 1 : 0);
            } else {
              return sum + (current ? 0 : 1);
            }
          }, 0),
    phqNine:
      screeningDetail.phqNine?.length === 0 ? -1 : screeningDetail.phqNine?.reduce((sum, current) => sum + current, 0),
    frailty:
      screeningDetail.frailty?.length === 0
        ? -1
        : screeningDetail.frailty?.reduce((sum, current, currentIndex) => {
            if (currentIndex === 0 || currentIndex === 1 || currentIndex === 4) {
              return sum + (current ? 1 : 0);
            } else {
              return sum + (current ? 0 : 1);
            }
          }, 0),
    drinking:
      screeningDetail.drinking?.length === 0
        ? -1
        : screeningDetail.drinking?.reduce((sum, current) => sum + current, 0),
    dementia:
      screeningDetail.dementia?.length === 0
        ? -1
        : screeningDetail.dementia?.reduce((sum, current) => sum + (current === 0 ? 1 : 0), 0),
    insomnia:
      screeningDetail.insomnia?.length === 0
        ? -1
        : screeningDetail.insomnia?.reduce((sum, current) => sum + current, 0),
    osa:
      screeningDetail.osa?.length === 0
        ? -1
        : screeningDetail.osa?.reduce((sum, current) => sum + (current ? 1 : 0), 0),
    smoking: screeningDetail.smoking?.length === 0 ? -1 : screeningDetail.smoking,
  };

  return { screeningDetail, totalScore };
};
