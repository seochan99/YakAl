import { EOrder } from "@type/enum/order.ts";
import { EExpertField } from "@type/enum/expert-field.ts";
import { TAdminExpertItem } from "@type/response/admin-expert-item.ts";
import { isAxiosError } from "axios";
import { getExpertRequestList } from "@api/auth/admin.ts";
import { EJob } from "@type/enum/job.ts";

export type TExpertListSort = {
  order: EOrder;
  field: EExpertField;
};

export class AdminExpertListModel {
  /* CONSTANTS */
  public static readonly EXPERT_COUNT_PER_PAGE = 10;

  /* PRIVATE MEMBER VARIABLE */
  private expertList: TAdminExpertItem[] | null = null;
  private totalCount: number | null = null;

  private pageNumber = 1;

  private sortBy: TExpertListSort = {
    order: EOrder.ASC,
    field: EExpertField.NAME,
  };

  private nameQuery = "";

  /* SINGLETON */
  private static instance: AdminExpertListModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (AdminExpertListModel.instance !== null) {
      return AdminExpertListModel.instance;
    }

    AdminExpertListModel.instance = new AdminExpertListModel();
    return AdminExpertListModel.instance;
  };

  /* PUBLIC METHOD */
  public fetch = async () => {
    try {
      const response = await getExpertRequestList(this.nameQuery, this.sortBy, this.pageNumber - 1);
      this.expertList = response.data.data.datalist.map((item) => {
        return {
          ...item,
          type: item.type === "DOCTOR" ? EJob.DOCTOR : EJob.PHARMACIST,
        };
      });
      this.pageNumber = response.data.data.pageInfo.page + 1;
      this.totalCount = response.data.data.pageInfo.totalElements;
    } catch (error) {
      if (isAxiosError(error)) {
        this.expertList = [];
        this.pageNumber = 1;
        this.totalCount = 0;
      }
    }
  };

  public invalidate = () => {
    this.expertList = null;
    this.pageNumber = 1;
    this.totalCount = 0;
  };

  public isLoading = () => this.expertList === null;

  public getExpertList = () => this.expertList;

  public getPagingInfo = () => ({ pageNumber: this.pageNumber, totalCount: this.totalCount });

  public getSortingInfo = () => this.sortBy;

  public getNameQuery = () => this.nameQuery;

  public setPageNumber = async (pageNumber: number) => {
    if (this.totalCount === null) {
      return;
    }

    if (1 > pageNumber || pageNumber > this.totalCount / AdminExpertListModel.EXPERT_COUNT_PER_PAGE + 1) {
      return;
    }

    this.pageNumber = pageNumber;
    await this.fetch();
  };

  public setSortBy = async (order: EOrder, field: EExpertField) => {
    this.sortBy = { order, field };
    await this.fetch();
  };

  public setNameQuery = async (nameQuery: string) => {
    this.nameQuery = nameQuery;
    await this.fetch();
  };
}
