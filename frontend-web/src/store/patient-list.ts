import { EOrder } from "@type/enum/order.ts";
import { EPatientField } from "@type/enum/patient-field.ts";
import { getPatientList, toggleIsFavorite } from "@api/auth/experts.ts";
import { isAxiosError } from "axios";

type TPatientItem = {
  id: number;
  name: string;
  birthday: number[];
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

  public invalidate = () => {
    this.patientList = null;
    this.totalCount = null;
  };

  /* PUBLIC METHOD */
  public fetch = async () => {
    try {
      const response = await getPatientList(this.sortBy, this.pageNumber, this.nameQuery, this.isOnlyManaged);

      this.patientList = (response.data.data! as { datalist: TPatientItem[] }).datalist;
      this.totalCount = (
        response.data.data! as {
          pageInfo: {
            page: number;
            size: number;
            totalElements: number;
            totalPages: number;
          };
        }
      ).pageInfo.totalElements;
    } catch (error) {
      this.patientList = [];
      this.totalCount = null;
    }
  };

  public isLoading = () => {
    return this.patientList === null || this.totalCount === 0;
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

  public toggleIsManaged = async (patientId: number) => {
    if (this.patientList === null) {
      return;
    }

    try {
      await toggleIsFavorite(patientId);

      if (this.isOnlyManaged) {
        await this.fetch();
        return;
      }

      const target = this.patientList.findLast((patientItem) => patientItem.id === patientId);

      if (!target) {
        return;
      }

      target.isFavorite = !target.isFavorite;
    } catch (error) {
      if (isAxiosError(error)) {
        return;
      }
    }
  };
}
