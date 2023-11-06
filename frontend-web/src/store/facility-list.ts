import { getApprovedFacilityList } from "@api/auth/experts.ts";
import { EJob } from "@type/job.ts";
import { EFacilityType } from "@type/facility-type.ts";
import { isAxiosError } from "axios";
import { TApprovedFacilityItem } from "@type/response/approved-facility-item.ts";

export class ExpertFacilityListModel {
  /* CONSTANTS */
  public static readonly FACILITY_COUNT_PER_PAGE = 5;

  /* PRIVATE MEMBER VARIABLE */
  private facilityList: TApprovedFacilityItem[] | null = null;
  private totalCount: number | null = null;

  private selectedJob: EJob | null = null;

  private pageNumber = 1;

  private nameQuery = "";

  /* SINGLETON */
  private static instance: ExpertFacilityListModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (ExpertFacilityListModel.instance !== null) {
      return ExpertFacilityListModel.instance;
    }

    ExpertFacilityListModel.instance = new ExpertFacilityListModel();
    return ExpertFacilityListModel.instance;
  };

  /* PUBLIC METHOD */
  public invalidate = async () => {
    this.facilityList = null;
  };

  public fetch = async () => {
    try {
      const response = await getApprovedFacilityList(
        this.nameQuery,
        this.pageNumber,
        this.selectedJob === EJob.DOCTOR ? EFacilityType.HOSPITAL : EFacilityType.PHARMACY,
      );

      this.facilityList = response.data.data.dataList;
      this.pageNumber = response.data.data.pageInfo.page + 1;
      this.totalCount = response.data.data.pageInfo.totalElements;
    } catch (error) {
      if (isAxiosError(error)) {
        this.facilityList = [];
        this.pageNumber = 1;
        this.totalCount = 0;
      }
    }
  };

  public isLoading = () => this.facilityList == null;

  public getFacilityList = () => this.facilityList;

  public getSelectedJob = () => this.selectedJob;

  public getPagingInfo = () => ({ pageNumber: this.pageNumber, totalCount: this.totalCount });

  public getNameQuery = () => this.nameQuery;

  public setPageNumber = async (pageNumber: number) => {
    if (this.totalCount === null) {
      return;
    }

    if (1 > pageNumber || pageNumber > this.totalCount / ExpertFacilityListModel.FACILITY_COUNT_PER_PAGE + 1) {
      return;
    }

    this.pageNumber = pageNumber;
    await this.fetch();
  };

  public setNameQuery = async (nameQuery: string) => {
    this.nameQuery = nameQuery;
    await this.fetch();
  };

  public setSelectedJob = async (job: EJob) => {
    this.selectedJob = job;
    await this.fetch();
  };
}
