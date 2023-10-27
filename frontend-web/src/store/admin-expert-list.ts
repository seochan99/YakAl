import { EOrder } from "@type/order.ts";
import { EJob } from "@type/job.ts";
import { EExpertField } from "@type/expert-field.ts";

export type TExpertItem = {
  id: number;
  job: EJob;
  name: string;
  requestedAt: Date;
  tel: string;
  belongName: string;
};

type TExpertListSort = {
  order: EOrder;
  field: EExpertField;
};

const expertList: TExpertItem[] = [
  {
    id: 1,
    job: EJob.DOCTOR,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원",
  },
  {
    id: 2,
    job: EJob.PHARMACIST,
    name: "맹약사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "서울아산병원",
  },
  {
    id: 3,
    job: EJob.DOCTOR,
    name: "박박사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "중앙대학교 부속병원",
  },
  {
    id: 4,
    job: EJob.DOCTOR,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원1",
  },
  {
    id: 5,
    job: EJob.DOCTOR,
    name: "박박사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원2",
  },
  {
    id: 6,
    job: EJob.PHARMACIST,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원3",
  },
  {
    id: 7,
    job: EJob.DOCTOR,
    name: "맹약사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원4",
  },
  {
    id: 8,
    job: EJob.PHARMACIST,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원5",
  },
  {
    id: 9,
    job: EJob.PHARMACIST,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원6",
  },
  {
    id: 10,
    job: EJob.DOCTOR,
    name: "맹약사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원7",
  },
  {
    id: 11,
    job: EJob.PHARMACIST,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원8",
  },
  {
    id: 12,
    job: EJob.PHARMACIST,
    name: "맹약사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원9",
  },
  {
    id: 13,
    job: EJob.PHARMACIST,
    name: "맹약사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원10",
  },
  {
    id: 14,
    job: EJob.DOCTOR,
    name: "김의사",
    requestedAt: new Date("2023-09-01"),
    tel: "01044444444",
    belongName: "분당 차병원11",
  },
];

export class AdminExpertListModel {
  /* CONSTANTS */
  public static readonly EXPERT_COUNT_PER_PAGE = 10;

  /* PRIVATE MEMBER VARIABLE */
  private expertList: TExpertItem[] | null = null;
  private totalCount: number | null = null;

  private pageNumber = 1;

  private sortBy: TExpertListSort = {
    order: EOrder.DESC,
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
    this.expertList = null;

    // Dummy async communication
    this.expertList = expertList.slice(
      (this.pageNumber - 1) * AdminExpertListModel.EXPERT_COUNT_PER_PAGE,
      this.pageNumber * AdminExpertListModel.EXPERT_COUNT_PER_PAGE,
    );

    this.totalCount = expertList.length;
  };

  public isLoading = () => this.expertList == null;

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
