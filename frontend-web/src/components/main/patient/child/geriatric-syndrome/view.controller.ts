import { PatientPageViewModel } from "../../view.model.ts";

export const useGeriatricSyndromeViewController = () => {
  const {
    patientInfo: { geriatricSyndrome },
  } = PatientPageViewModel.getStates();

  const totalScore = {
    mna: geriatricSyndrome.mna?.length === 0 ? -1 : geriatricSyndrome.mna?.reduce((sum, current) => sum + current, 0),
    adl:
      geriatricSyndrome.mna?.length === 0
        ? -1
        : geriatricSyndrome.adl?.reduce(
            (sum, current, currentIndex) =>
              sum + (currentIndex === geriatricSyndrome.adl?.length ? (current ? 0 : 1) : current ? 1 : 0),
            0,
          ),
    delirium:
      geriatricSyndrome.mna?.length === 0
        ? -1
        : geriatricSyndrome.delirium?.reduce((sum, current) => sum + (current ? 1 : 0), 0),
    audioVisual: geriatricSyndrome.audiovisual,
  };

  const kaztADLQuestion = [
    "목욕",
    "옷 입고 벗기",
    "화장실 다녀오기",
    "이동",
    "식사",
    "요실금이나 변실금이 있으십니까?",
  ];

  const deliriumQuestion = [
    "입원 중에 본인이 어디에 있는지 모르거나 병원이 아닌 곳에 있다고 느낀 적이 있다.",
    "입원 중에 날짜가 몇일인지 혹은 무슨 요일인지 인지하는데 어려움이 많았다.",
    "입원 중에 가족이나 친한 지인이 누구인지 몰라봤던 적이 있었다.",
    "입원 중에 환각이나 환청을 경험한 적이 있었다.",
  ];

  return { geriatricSyndrome, totalScore, question: { kaztADLQuestion, deliriumQuestion } };
};
