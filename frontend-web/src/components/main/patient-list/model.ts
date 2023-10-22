import { ESex } from "../../../../type/sex.ts";
import { EOrder } from "../../../../type/order.ts";
import { EPatientField } from "../../../../type/patient-field.ts";

type TPatientItem = {
  id: number;
  profileImg: string;
  name: string;
  birthday: number[];
  sex: ESex;
  lastQuestionnaireDate: number[];
  tel: string;
  isManaged: boolean;
};

// Dummy
const patientList = [
  {
    id: 1,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: true,
  },
  {
    id: 2,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: true,
  },
  {
    id: 3,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: true,
  },
  {
    id: 4,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: true,
  },
  {
    id: 5,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 6,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 7,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 8,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 9,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 10,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 11,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
  {
    id: 12,
    profileImg: "",
    name: "홍길동",
    birthday: [1992, 12, 12],
    sex: ESex.MALE,
    lastQuestionnaireDate: [2022, 12, 12],
    tel: "010-1111-1111",
    isManaged: false,
  },
];

export class PatientListModel {
  /* CONSTANTS */
  public static readonly PATIENT_COUNT_PER_PAGE = 10;

  /* PRIVATE MEMBER VARIABLE */
  private patientList: TPatientItem[] | null = null;
  private totalCount: number | null = null;

  private pageNumber = 1;

  private sortBy = {
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

  /* PUBLIC METHOD */
  public fetch = async () => {
    // Dummy
    this.patientList = null;
    if (this.isOnlyManaged) {
      this.patientList = patientList.filter((patientItem) => patientItem.isManaged);
    } else {
      this.patientList = patientList;
    }
    this.totalCount = this.patientList.length;
    if (this.pageNumber === 1) this.patientList = this.patientList.slice(0, 10);
    else this.patientList = this.patientList.slice(10, 12);
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

  public setIsManaged = async (patientId: number, isManaged: boolean) => {
    if (!this.patientList) {
      return;
    }

    const patient = this.patientList.findLast((patientItem) => patientItem.id === patientId);

    if (!patient) {
      return;
    }

    patient.isManaged = isManaged;
    await this.fetch();
  };
}
