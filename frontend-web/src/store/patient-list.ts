import { ESex } from "@type/sex.ts";
import { EOrder } from "@type/order.ts";
import { EPatientField } from "@type/patient-field.ts";
import { toggleIsFavorite } from "@api/auth/experts/api.ts";

type TPatientItem = {
  id: number;
  name: string;
  birthday: number[];
  sex: ESex;
  lastQuestionnaireDate: number[];
  tel: string;
  isFavorite: boolean;
};

export type TSortBy = {
  order: EOrder;
  field: EPatientField;
};

export class PatientListModel {
  /* CONSTANTS */
  public static readonly PATIENT_COUNT_PER_PAGE = 10;

  /* PRIVATE MEMBER VARIABLE */
  private patientList: TPatientItem[] | null = null;
  private totalCount: number | null = null;

  private pageNumber = 1;

  private sortBy: TSortBy = {
    order: EOrder.DESC,
    field: EPatientField.LAST_QUESTIONNAIRE_DATE,
  };

  private nameQuery = "";

  private isOnlyManaged = true;

  /* SINGLETON */
  private static instance: PatientListModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (PatientListModel.instance !== null) {
      return PatientListModel.instance;
    }

    PatientListModel.instance = new PatientListModel();
    return PatientListModel.instance;
  };

  public invalidate = async () => {
    this.patientList = null;
  };

  /* PUBLIC METHOD */
  public fetch = async () => {
    this.patientList = [
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: false,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: false,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: true,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: true,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: true,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: false,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: false,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: true,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: true,
      },
      {
        id: 1,
        name: "홍길동",
        birthday: [1992, 12, 12],
        sex: ESex.MALE,
        lastQuestionnaireDate: [2022, 12, 12],
        tel: "010-1111-1111",
        isFavorite: true,
      },
    ];

    this.totalCount = this.patientList.length;
    // try {
    //   const response = await getPatientList(this.sortBy, this.pageNumber, this.nameQuery);
    //
    //   this.patientList = (response.data.data! as { datalist: TPatientItem[] }).datalist;
    //   this.totalCount = (
    //     response.data.data! as {
    //       pageInfo: {
    //         page: number;
    //         size: number;
    //         totalElements: number;
    //         totalPages: number;
    //       };
    //     }
    //   ).pageInfo.totalElements;
    // } catch (error) {
    //   this.patientList = [];
    // }
  };

  public isLoading = () => {
    return this.patientList === null;
  };

  public getPatientList = () => {
    return this.patientList;
  };

  public getPagingInfo = () => {
    return { pageNumber: this.pageNumber, totalCount: this.totalCount };
  };

  public getSortingInfo = () => {
    return this.sortBy;
  };

  public getNameQuery = () => {
    return this.nameQuery;
  };

  public getIsOnlyManaged = () => {
    return this.isOnlyManaged;
  };

  public setPageNumber = async (pageNumber: number) => {
    if (this.totalCount === null) {
      return;
    }

    if (1 > pageNumber || pageNumber > this.totalCount / PatientListModel.PATIENT_COUNT_PER_PAGE + 1) {
      return;
    }

    this.pageNumber = pageNumber;
    await this.fetch();
  };

  public setSortBy = async (order: EOrder, field: EPatientField) => {
    this.sortBy = { order, field };
    await this.fetch();
  };

  public setNameQuery = async (nameQuery: string) => {
    this.nameQuery = nameQuery;
    await this.fetch();
  };

  public setIsOnlyManaged = async (isOnlyManaged: boolean) => {
    this.isOnlyManaged = isOnlyManaged;
    this.pageNumber = 1;
    this.sortBy = {
      order: EOrder.DESC,
      field: EPatientField.LAST_QUESTIONNAIRE_DATE,
    };
    this.nameQuery = "";
    await this.fetch();
  };

  public setIsManaged = async (patientId: number) => {
    if (!this.patientList) {
      return;
    }

    await toggleIsFavorite(patientId);
    await this.fetch();
  };
}
