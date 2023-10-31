import { ESex } from "@type/sex.ts";
import { EPatientInfoTab } from "@type/patient-info-tab.ts";
import { getLatestDoses } from "@api/auth/experts/api.ts";

type TPatientInfo = {
  base: {
    name: string;
    profileImg: string;
    birthday: number[];
    sex: ESex;
    tel: string;
  } | null;
  protector: {
    name: string;
    relationship: string;
    tel: string;
  } | null;
  medication: {
    etc: {
      list:
        | {
            name: string;
            prescribedAt: number[];
          }[]
        | null;
      page: number;
      total: number | null;
    }; // 전문의약품
    armsProgress:
      | {
          score: number;
          createdAt: number[];
        }[]
      | null; // ARMS 추이
    beersCriteriaMedicines: {
      list:
        | {
            name: string;
            prescribedAt: number[];
          }[]
        | null;
      page: number;
      total: number | null;
    }; // 비어스 기준 약물
    anticholinergicDrugs: {
      list:
        | {
            name: string;
            prescribedAt: number[];
            riskLevel: number;
          }[]
        | null;
      page: number;
      total: number | null;
    }; // 항콜린성 약물
  };
  geriatricSyndrome: {
    mna: number[];
    adl: boolean[];
    delirium: boolean[];
    audiovisual: {
      useGlasses: boolean;
      useHearingAid: boolean;
    };
    fall: number[][];
  } | null;
  screeningDetail: {
    arms: number[];
    gds: boolean[];
    phqNine: number[];
    frailty: boolean[];
    drinking: number[];
    dementia: number[];
    insomnia: number[];
    osa: boolean[];
    smoking: number[];
  } | null;
};

export class PatientModel {
  private static patientInfo: TPatientInfo = {
    base: null,
    protector: null,
    medication: {
      etc: {
        list: null,
        page: 1,
        total: null,
      },
      armsProgress: null,
      beersCriteriaMedicines: {
        list: null,
        page: 1,
        total: null,
      },
      anticholinergicDrugs: {
        list: null,
        page: 1,
        total: null,
      },
    },
    geriatricSyndrome: null,
    screeningDetail: null,
  };
  private static currentTab: EPatientInfoTab = EPatientInfoTab.SUMMARY;

  private static readonly patientInfoTab = [
    { kor: "요약", eng: "Summary" },
    { kor: "투약 정보", eng: "Medication" },
    { kor: "노인병 증후군", eng: "Geriatric Syndrome" },
    { kor: "설문 결과", eng: "Screening" },
  ];

  public static invalidate = () => {
    this.patientInfo = {
      base: null,
      protector: null,
      medication: {
        etc: {
          list: null,
          page: 1,
          total: null,
        },
        armsProgress: null,
        beersCriteriaMedicines: {
          list: null,
          page: 1,
          total: null,
        },
        anticholinergicDrugs: {
          list: null,
          page: 1,
          total: null,
        },
      },
      geriatricSyndrome: null,
      screeningDetail: null,
    };
  };

  public static invalidateBase = () => {
    this.patientInfo.base = null;
  };

  public static invalidateProtector = () => {
    this.patientInfo.protector = null;
  };

  public static invalidateETC = () => {
    this.patientInfo.medication.etc = {
      list: null,
      page: 1,
      total: null,
    };
  };

  public static invalidateBeersList = () => {
    this.patientInfo.medication.beersCriteriaMedicines = {
      list: null,
      page: 1,
      total: null,
    };
  };

  public static invalidateAnticholinergic = () => {
    this.patientInfo.medication.anticholinergicDrugs = {
      list: null,
      page: 1,
      total: null,
    };
  };

  public static invalidateARMS = () => {
    this.patientInfo.medication.armsProgress = null;
  };

  public static invalidateGeriatricSyndrome = () => {
    this.patientInfo.geriatricSyndrome = null;
  };

  public static invalidateScreening = () => {
    this.patientInfo.screeningDetail = null;
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchBase = async (patientId: number) => {
    this.patientInfo.base = {
      name: "홍길동",
      profileImg: "",
      birthday: [1993, 12, 19],
      sex: ESex.MALE,
      tel: "010-1111-1111",
    };
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchProtector = async (patientId: number) => {
    this.patientInfo.protector = {
      name: "홍귀동",
      relationship: "형제",
      tel: "010-2222-2222",
    };
  };

  public static fetchLastETC = async (patientId: number) => {
    try {
      const response = await getLatestDoses(patientId);

      this.patientInfo.medication.etc = {
        list: response.data.data,
        page: 1,
        total: null,
      };
    } catch (error) {
      this.patientInfo.medication.etc = {
        list: [],
        page: 1,
        total: null,
      };
    }
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchETC = async (patientId: number) => {
    this.patientInfo.medication.etc = {
      ...this.patientInfo.medication.etc,
      list: [
        { name: "동화디트로판정", prescribedAt: [2023, 9, 23] },
        {
          name: "가나릴정",
          prescribedAt: [2023, 9, 23],
        },
        { name: "아낙정", prescribedAt: [2023, 9, 22] },
        { name: "스토가정", prescribedAt: [2023, 9, 20] },
        { name: "네가박트정", prescribedAt: [2023, 9, 16] },
      ],
      total: 5,
    };
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchBeersList = async (patientId: number) => {
    this.patientInfo.medication.beersCriteriaMedicines = {
      list: [
        { name: "동화디트로판정", prescribedAt: [2023, 9, 23] },
        {
          name: "가나릴정",
          prescribedAt: [2023, 9, 23],
        },
        { name: "아낙정", prescribedAt: [2023, 9, 22] },
        { name: "스토가정", prescribedAt: [2023, 9, 20] },
        { name: "네가박트정", prescribedAt: [2023, 9, 16] },
      ],
      page: 1,
      total: 5,
    };
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchAnticholinergic = async (patientId: number) => {
    this.patientInfo.medication.anticholinergicDrugs = {
      list: [
        { name: "동화디트로판정", prescribedAt: [2023, 9, 23], riskLevel: 1 },
        {
          name: "가나릴정",
          prescribedAt: [2023, 9, 23],
          riskLevel: 2,
        },
        { name: "아낙정", prescribedAt: [2023, 9, 22], riskLevel: 3 },
        { name: "스토가정", prescribedAt: [2023, 9, 20], riskLevel: 1 },
        { name: "네가박트정", prescribedAt: [2023, 9, 16], riskLevel: 2 },
      ],
      page: 1,
      total: 5,
    };
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchARMS = async (patientId: number) => {
    this.patientInfo.medication.armsProgress = [
      { score: 40, createdAt: [2023, 1, 1] },
      { score: 36, createdAt: [2023, 4, 1] },
      { score: 42, createdAt: [2023, 7, 1] },
      { score: 46, createdAt: [2023, 10, 1] },
    ];
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchGeriatricSyndrome = async (patientId: number) => {
    this.patientInfo.geriatricSyndrome = {
      mna: [0, 0, 1, 0, 1, 3],
      adl: [false, false, false, false, false, true],
      delirium: [false, true, true, false],
      audiovisual: {
        useGlasses: true,
        useHearingAid: true,
      },
      fall: [
        [2023, 7, 11],
        [2023, 6, 1],
      ],
    };
  };

  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  public static fetchScreening = async (patientId: number) => {
    this.patientInfo.screeningDetail = {
      arms: [1, 2, 3, 4, 4, 3, 4, 1, 1, 2, 1, 4],
      gds: [true, true, false, true, true, true, false, true, true, true, false, true, true, true],
      phqNine: [0, 1, 2, 3, 2, 3, 3, 3, 2],
      frailty: [true, true, false, false, true],
      drinking: [0, 1, 2, 3, 4, 4, 4, 4, 4, 4],
      dementia: [2, 1, 0, 0, 0, 0, 0, 0],
      insomnia: [4, 3, 4, 2, 1, 0, 3],
      osa: [false, true, true, false, true, true, false, true],
      smoking: [2, 20, 1],
    };
  };

  public static getPatientInfo = () => {
    return this.patientInfo;
  };

  public static getCurrentTab = () => {
    return this.currentTab;
  };

  public static getTabInfos = () => {
    return this.patientInfoTab;
  };

  public static getETCPage = async () => {
    return this.patientInfo.medication.etc.page;
  };

  public static getBeersListPage = async () => {
    return this.patientInfo.medication.beersCriteriaMedicines.page;
  };

  public static setCurrentTab = async (tab: EPatientInfoTab) => {
    this.currentTab = tab;
  };

  public static setETCPage = async (page: number, patientId: number) => {
    this.patientInfo.medication.etc.page = page;
    await this.fetchETC(patientId);
  };

  public static setBeersListPage = async (page: number, patientId: number) => {
    this.patientInfo.medication.beersCriteriaMedicines.page = page;
    await this.fetchBeersList(patientId);
  };

  public static setAnticholinergicDrugsPage = async (page: number, patientId: number) => {
    this.patientInfo.medication.anticholinergicDrugs.page = page;
    await this.fetchAnticholinergic(patientId);
  };
}
