import { EPatientInfoTab } from "@type/patient-info-tab.ts";
import {
  getGeneralSurvey,
  getGeriatricSyndromeSurvey,
  getLatestDoses,
  getPatientBaseInfo,
  getProtectorInfo,
} from "@api/auth/experts/api.ts";
import { isAxiosError } from "axios";
import { TPatientBase } from "@api/auth/experts/types/patient-base.ts";
import { TProtectorInfo } from "@api/auth/experts/types/protector-info.ts";
import { TDoseInfo } from "@api/auth/experts/types/dose-info.ts";
import { TGeriatricSyndromeResult } from "@api/auth/experts/types/geriatric-syndrome-result.ts";
import { TGeneralSurveyResult } from "@api/auth/experts/types/general-survey-result.ts";

type TPatientInfo = {
  base: TPatientBase | null;
  protector: TProtectorInfo | null;
  medication: {
    etc: {
      list: TDoseInfo[] | null;
      page: number | null;
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
  geriatricSyndrome: TGeriatricSyndromeResult;
  screeningDetail: TGeneralSurveyResult;
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
    geriatricSyndrome: {
      mna: null,
      adl: null,
      delirium: null,
      audiovisual: null,
      fall: null,
    },
    screeningDetail: {
      arms: null,
      gds: null,
      phqNine: null,
      frailty: null,
      drinking: null,
      dementia: null,
      insomnia: null,
      osa: null,
      smoking: null,
    },
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
      geriatricSyndrome: {
        mna: null,
        adl: null,
        delirium: null,
        audiovisual: null,
        fall: null,
      },
      screeningDetail: {
        arms: null,
        gds: null,
        phqNine: null,
        frailty: null,
        drinking: null,
        dementia: null,
        insomnia: null,
        osa: null,
        smoking: null,
      },
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
    this.patientInfo.geriatricSyndrome = {
      mna: null,
      adl: null,
      delirium: null,
      audiovisual: null,
      fall: null,
    };
  };

  public static invalidateScreening = () => {
    this.patientInfo.screeningDetail = {
      arms: null,
      gds: null,
      phqNine: null,
      frailty: null,
      drinking: null,
      dementia: null,
      insomnia: null,
      osa: null,
      smoking: null,
    };
  };

  public static fetchBase = async (patientId: number) => {
    try {
      const response = await getPatientBaseInfo(patientId);

      this.patientInfo.base = response.data.data;
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.base = {
          name: "",
          birthday: [],
          tel: "",
        };
      }
    }
  };

  public static fetchProtector = async (patientId: number) => {
    try {
      const response = await getProtectorInfo(patientId);

      this.patientInfo.protector = response.data.data;
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.protector = {
          id: -1,
          realName: "",
          tel: "",
        };
      }
    }
  };

  public static fetchLastETC = async (patientId: number) => {
    try {
      const response = await getLatestDoses(patientId);

      this.patientInfo.medication.etc = { list: response.data.data, page: 1, total: response.data.data.length };
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.medication.etc = {
          list: [],
          page: 0,
          total: 0,
        };
      }
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

  public static fetchGeriatricSyndrome = async (patientId: number) => {
    try {
      const response = await getGeriatricSyndromeSurvey(patientId);
      this.patientInfo.geriatricSyndrome = response.data.data;
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.geriatricSyndrome = {
          mna: [],
          adl: [],
          delirium: [],
          audiovisual: { useGlasses: null, useHearingAid: null },
          fall: [],
        };
      }
    }
  };

  public static fetchScreening = async (patientId: number) => {
    try {
      const response = await getGeneralSurvey(patientId);
      this.patientInfo.screeningDetail = response.data.data;
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.screeningDetail = {
          arms: [],
          gds: [],
          phqNine: [],
          frailty: [],
          drinking: [],
          dementia: [],
          insomnia: [],
          osa: [],
          smoking: [],
        };
      }
    }
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

  public static isLoading = () => {
    if (this.currentTab === EPatientInfoTab.SUMMARY) {
      return (
        this.patientInfo.base === null ||
        this.patientInfo.protector === null ||
        this.patientInfo.medication.etc === null ||
        this.patientInfo.geriatricSyndrome.mna === null ||
        this.patientInfo.screeningDetail.arms === null
      );
    }

    return false;
  };
}
