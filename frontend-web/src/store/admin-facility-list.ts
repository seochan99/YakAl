import { EOrder } from "@type/order.ts";
import { EFacilityField } from "@type/facility-field.ts";
import { getFacilityRequestList } from "@api/auth/admin.ts";
import { TAdminFacilityItem } from "@type/response/admin-facility-item.ts";
import { isAxiosError } from "axios";
import { EFacilityType } from "@type/facility-type.ts";

export type TFacilityListSortType = {
  order: EOrder;
  field: EFacilityField;
};

export class AdminFacilityListModel {
  /* CONSTANTS */
  public static readonly FACILITY_COUNT_PER_PAGE = 10;

  /* PRIVATE MEMBER VARIABLE */
  private facilityList: TAdminFacilityItem[] | null = null;
  private totalCount: number | null = null;

  private pageNumber = 1;

  private sortBy: TFacilityListSortType = {
    order: EOrder.ASC,
    field: EFacilityField.NAME,
  };

  private nameQuery = "";

  /* SINGLETON */
  private static instance: AdminFacilityListModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (AdminFacilityListModel.instance !== null) {
      return AdminFacilityListModel.instance;
    }

    AdminFacilityListModel.instance = new AdminFacilityListModel();
    return AdminFacilityListModel.instance;
  };

  /* PUBLIC METHOD */
  public fetch = async () => {
    try {
      const response = await getFacilityRequestList(this.nameQuery, this.sortBy, this.pageNumber - 1);
      this.facilityList = response.data.data.datalist.map((item) => {
        return {
          ...item,
          type: item.type === "HOSPITAL" ? EFacilityType.HOSPITAL : EFacilityType.PHARMACY,
        };
      });
      this.totalCount = response.data.data.pageInfo.totalElements;
      this.pageNumber = response.data.data.pageInfo.page + 1;
    } catch (error) {
      if (isAxiosError(error)) {
        this.facilityList = [];
        this.totalCount = 0;
        this.pageNumber = 1;
      }
    }
  };

  public invalidate = () => {
    this.facilityList = null;
    this.totalCount = 0;
  };

  public isLoading = () => this.facilityList == null;

  public getFacilityList = () => this.facilityList;

  public getPagingInfo = () => ({ pageNumber: this.pageNumber, totalCount: this.totalCount });

  public getSortingInfo = () => this.sortBy;

  public getNameQuery = () => this.nameQuery;

  public setPageNumber = async (pageNumber: number) => {
    if (this.totalCount === null) {
      return;
    }

    if (1 > pageNumber || pageNumber > this.totalCount / AdminFacilityListModel.FACILITY_COUNT_PER_PAGE + 1) {
      return;
    }

    this.pageNumber = pageNumber;
    await this.fetch();
  };

  public setSortBy = async (order: EOrder, field: EFacilityField) => {
    this.sortBy = { order, field };
    await this.fetch();
  };

  public setNameQuery = async (nameQuery: string) => {
    this.nameQuery = nameQuery;
    await this.fetch();
  };
}
