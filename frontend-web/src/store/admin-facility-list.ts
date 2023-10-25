import { EOrder } from "@type/order.ts";
import { EFacilityType } from "@type/facility-type.ts";
import { EFacilityField } from "@type/facility-field.ts";

type TFacilityItem = {
  id: number;
  name: string;
  representative: string;
  representativeTel: string;
  facilityType: EFacilityType;
  requested_at: Date;
};

type TFacilityListSortType = {
  order: EOrder;
  field: EFacilityField;
};

const facilityList: TFacilityItem[] = [
  {
    id: 1,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원1",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 2,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원2",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 3,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원3",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 4,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원4",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 5,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원5",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 6,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원6",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 7,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원7",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 8,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원8",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 9,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원9",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 10,
    facilityType: EFacilityType.HOSPITAL,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원10",
    requested_at: new Date("2023-09-01"),
  },
  {
    id: 11,
    facilityType: EFacilityType.PHARMACY,
    representativeTel: "01044444444",
    representative: "홍길동",
    name: "분당 차병원11",
    requested_at: new Date("2023-09-01"),
  },
];

export class AdminFacilityListModel {
  /* CONSTANTS */
  public static readonly FACILITY_COUNT_PER_PAGE = 10;

  /* PRIVATE MEMBER VARIABLE */
  private facilityList: TFacilityItem[] | null = null;
  private totalCount: number | null = null;

  private pageNumber = 1;

  private sortBy: TFacilityListSortType = {
    order: EOrder.DESC,
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
    this.facilityList = null;

    // Dummy async communication
    this.facilityList = facilityList.slice(
      (this.pageNumber - 1) * AdminFacilityListModel.FACILITY_COUNT_PER_PAGE,
      this.pageNumber * AdminFacilityListModel.FACILITY_COUNT_PER_PAGE,
    );

    this.totalCount = facilityList.length;
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
