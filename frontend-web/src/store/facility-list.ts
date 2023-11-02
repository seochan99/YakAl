import { getApprovedFacilityList } from "@api/auth/experts/api.ts";
import { EJob } from "@type/job.ts";
import { EFacilityType } from "@type/facility-type.ts";

export type TExpertFacilityItem = {
  id: number;
  name: string;
  address: string;
};

export class ExpertFacilityListModel {
  /* CONSTANTS */
  public static readonly FACILITY_COUNT_PER_PAGE = 5;

  /* PRIVATE MEMBER VARIABLE */
  private facilityList: TExpertFacilityItem[] | null = null;
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
    getApprovedFacilityList(
      this.nameQuery,
      this.pageNumber,
      this.selectedJob === EJob.DOCTOR ? EFacilityType.HOSPITAL : EFacilityType.PHARMACY,
    ).then((value) => {
      this.facilityList = value.data.data!;
    });
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
