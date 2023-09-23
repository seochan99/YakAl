import { ESex } from "../../../../type/sex.ts";
import { EPatientInfoTab } from "../../../../type/patient-info-tab.ts";

const patientInfoTab = {
  summary: { kor: "요약", eng: "Summary" },
  medication: { kor: "투약 정보", eng: "Medication" },
  note: { kor: "기록", eng: "Note" },
  geriatricSyndrome: { kor: "노인병 증후군 설문", eng: "Geriatric Syndrome" },
  screening: { kor: "설문 결과", eng: "Screening" },
};

const patientInfo: TPatientInfo = {
  base: {
    name: "홍길동",
    profileImg: "",
    birthday: [1993, 12, 19],
    sex: ESex.MALE,
    tel: "010-1111-1111",
  },
  nextOfKin: {
    name: "홍귀동",
    relationship: "형제",
    tel: "010-2222-2222",
  },
  medication: {
    etc: [
      { name: "동화디트로판정", prescribedAt: [2023, 9, 23] },
      {
        name: "가나릴정",
        prescribedAt: [2023, 9, 23],
      },
      { name: "아낙정", prescribedAt: [2023, 9, 22] },
      { name: "스토가정", prescribedAt: [2023, 9, 20] },
    ],
    otc: [
      { name: "타이레놀", prescribedAt: [2023, 9, 19] },
      { name: "타이레놀", prescribedAt: [2023, 9, 19] },
      {
        name: "타이레놀",
        prescribedAt: [2023, 9, 19],
      },
      { name: "타이레놀", prescribedAt: [2023, 9, 19] },
      { name: "타이레놀", prescribedAt: [2023, 9, 19] },
      {
        name: "타이레놀",
        prescribedAt: [2023, 9, 19],
      },
      { name: "타이레놀", prescribedAt: [2023, 9, 19] },
    ],
    supplement: [
      { name: "오메가3" },
      { name: "비타민A" },
      { name: "비타민B" },
      { name: "비타민C" },
      { name: "비타민D" },
      { name: "비타민E" },
    ],
    armsProgress: [{ score: 40 }, { score: 36 }, { score: 42 }, { score: 46 }],
    beersCriteriaMedicines: [{ name: "가나릴정", prescribedAt: [2023, 9, 23] }],
    anticholinergicDrugs: [{ name: "동화디트로판정", prescribedAt: [2023, 9, 23] }],
  },
  note: {
    admission: [{ hospitalName: "중앙대학교 부속병원", start: [2023, 8, 20], end: [2023, 8, 23] }],
    emergency: [{ hospitalName: "중앙대학교 부속병원", start: [2023, 9, 2], end: [2023, 9, 7] }],
    problemList: [
      { name: "고혈압", createdAt: [2023, 9, 12] },
      { name: "치매", createdAt: [2023, 9, 10] },
      {
        name: "당뇨",
        createdAt: [2023, 9, 8],
      },
    ],
    allergy: [{ name: "꽃가루 알레르기", createdAt: [2023, 9, 6] }],
  },
  screeningSummary: {
    arms: { score: 46 },
    gds: { score: 14 },
    phqNine: { score: 26 },
    frailty: { score: 4 },
    mna: { score: 2 },
    adl: { score: 1 },
    drinking: { score: 40 },
    smoking: {
      isSmoking: true,
      smokingYear: 25,
      smokingAmountPerDay: "2갑 이상",
    },
    audiovisual: {
      useGlasses: true,
      useHearingAid: true,
    },
    dementia: { score: 6 },
    delirium: { score: 3 },
    insomnia: { score: 24 },
    osa: { score: 6 },
  },
  geriatricSyndrome: {
    fallPastTwelveMonths: [{ date: [2023, 9, 22] }, { date: [2023, 9, 21] }, { date: [2023, 9, 20] }],
  },
  screeningDetail: {
    arms: [4, 4, 4, 4, 3, 4, 4, 4, 3, 4, 4, 4],
    gds: [0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1],
    phqNine: [4, 4, 4, 4, 3, 4, 4, 4, 4],
    frailty: [1, 1, 0, 0, 0],
    mna: [2, 2, 1, 1, 1, 1],
    adl: [1, 0, 0, 0, 0, 0],
    drinking: [5, 5, 5, 5, 5, 5, 5, 5, 5, 5],
    dementia: [0, 0, 0, 0, 0, 0, 1, 2],
    delirium: [0, 0, 1, 0],
    insomnia: [5, 5, 5, 1, 5, 5, 1],
    osa: [0, 1, 0, 0, 1, 0, 0, 0],
  },
};

type TPatientInfo = {
  base: {
    name: string;
    profileImg: string;
    birthday: number[];
    sex: ESex;
    tel: string;
  };
  nextOfKin: {
    name: string;
    relationship: string;
    tel: string;
  };
  newEvent: {
    newMedicine: { name: string; prescribedAt: number[] };
    newAdmission: { hospitalName: string; start: number[]; end: number[] };
    newEmergency: { hospitalName: string; start: number[]; end: number[] };
  };
  medication: {
    etc: { name: string; prescribedAt: number[] }[]; // 전문의약품
    otc: { name: string; prescribedAt: number[] }[]; // 일반의약품
    supplement: { name: string }[]; // 영양제
    armsProgress: { score: number }[]; // ARMS 추이
    beersCriteriaMedicines: { name: string; prescribedAt: number[] }[]; // 비어스 기준 약물
    anticholinergicDrugs: { name: string; prescribedAt: number[] }[]; // 항콜린성 약물
  };
  note: {
    admission: { hospitalName: string; start: number[]; end: number[] }[];
    emergency: { hospitalName: string; start: number[]; end: number[] }[];
    problemList: {
      name: string;
      createdAt: number[];
    }[];
    allergy: {
      name: string;
      createdAt: number[];
    }[];
  };
  screeningSummary: {
    arms: { score: number }; // 복약 순응도 테스트(ARMS)
    gds: { score: number }; // 우울 척도 테스트(GDS)
    phqNine: { score: number }; // 우울증 선별 검사(PHQ-9)
    frailty: { score: number }; // 노쇠 테스트(Frailty)
    mna: { score: number }; // 간이 영양 상태 조사(MNA)
    adl: { score: number }; // 일상생활 동작 지수
    drinking: { score: number }; // 음주력 테스트(CDT)
    smoking: {
      isSmoking: boolean;
      smokingYear: number;
      smokingAmountPerDay: string;
    }; // 흡연력 테스트
    audiovisual: {
      useGlasses: boolean;
      useHearingAid: boolean;
    }; // 시청각 테스트
    dementia: { score: number }; // 치매 테스트
    delirium: { score: number }; // 섬망 테스트
    insomnia: { score: number }; // 불면증 심각도
    osa: { score: number }; // 폐쇄성 수면 무호흡증
  };
  geriatricSyndrome: {
    fallPastTwelveMonths: { date: number[] }[];
  };
  screeningDetail: {
    arms: number[];
    gds: number[];
    phqNine: number[];
    frailty: number[];
    mna: number[];
    adl: number[];
    drinking: number[];
    dementia: number[];
    delirium: number[];
    insomnia: number[];
    osa: number[];
  };
};

export class PatientModel {
  private static patientInfo: TPatientInfo | null;
  private static currentTab: EPatientInfoTab = EPatientInfoTab.SUMMARY;
}
