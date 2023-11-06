import { EPatientInfoTab } from "@type/patient-info-tab.ts";
import {
  getAnticholinergicDoses,
  getBeersDoses,
  getDoses,
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
import { TDoseWithRisk } from "@api/auth/experts/types/dose-with-risk.ts";

type TPatientInfo = {
  base: TPatientBase | null;
  protector: TProtectorInfo | null;
  medication: {
    // 전문의약품
    etc: {
      list: TDoseInfo[] | null;
      page: number;
      total: number | null;
    };
    // ARMS 추이
    armsProgress:
      | {
          score: number;
          createdAt: number[];
        }[]
      | null;
    // 비어스 기준 약물
    beersCriteriaMedicines: {
      list: TDoseInfo[] | null;
      page: number;
      total: number | null;
    };
    // 항콜린성 약물
    anticholinergicDrugs: {
      list: TDoseWithRisk[] | null;
      page: number;
      total: number | null;
    };
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

  public static fetchETC = async (patientId: number) => {
    try {
      const response = await getDoses(patientId, this.patientInfo.medication.etc.page);

      this.patientInfo.medication.etc = {
        list: response.data.data.datalist,
        page: response.data.data.pageInfo.page + 1,
        total: response.data.data.pageInfo.totalElements,
      };
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

  public static fetchBeersList = async (patientId: number) => {
    try {
      const response = await getBeersDoses(patientId, this.patientInfo.medication.beersCriteriaMedicines.page);

      this.patientInfo.medication.beersCriteriaMedicines = {
        list: response.data.data.datalist,
        page: response.data.data.pageInfo.page + 1,
        total: response.data.data.pageInfo.totalElements,
      };
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.medication.beersCriteriaMedicines = {
          list: [],
          page: 0,
          total: 0,
        };
      }
    }
  };

  public static fetchAnticholinergic = async (patientId: number) => {
    try {
      const response = await getAnticholinergicDoses(patientId, this.patientInfo.medication.anticholinergicDrugs.page);

      this.patientInfo.medication.anticholinergicDrugs = {
        list: response.data.data.datalist,
        page: response.data.data.pageInfo.page + 1,
        total: response.data.data.pageInfo.totalElements,
      };
    } catch (error) {
      if (isAxiosError(error)) {
        this.patientInfo.medication.anticholinergicDrugs = {
          list: [],
          page: 0,
          total: 0,
        };
      }
    }
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
    return (
      this.patientInfo.base === null ||
      this.patientInfo.protector === null ||
      this.patientInfo.medication.etc === null ||
      this.patientInfo.geriatricSyndrome.mna === null ||
      this.patientInfo.medication.beersCriteriaMedicines === null ||
      this.patientInfo.medication.anticholinergicDrugs === null ||
      this.patientInfo.screeningDetail.arms === null
    );
  };
}
