import React, { useState } from "react";
import { ExpertFacilityListModel } from "@store/facility-list.ts";
import { EJob } from "@type/job.ts";

export class ExpertFacilityListViewModel {
  private static updater = false;
  private static setState: React.Dispatch<React.SetStateAction<boolean>>;

  private static expertFacilityListModel = ExpertFacilityListModel.getInstance();

  private static flush = () => {
    if (this.setState === undefined) {
      return;
    }
    this.setState(!this.updater);
  };

  public static use = () => {
    [this.updater, this.setState] = useState<boolean>(false);
  };

  public static fetch = async () => {
    this.expertFacilityListModel.invalidate();
    this.flush();
    await this.expertFacilityListModel.fetch();
    this.flush();
  };

  public static getState = () => {
    return {
      isLoading: this.expertFacilityListModel.isLoading(),
      facilityList: this.expertFacilityListModel.getFacilityList(),
      pagingInfo: this.expertFacilityListModel.getPagingInfo(),
      nameQuery: this.expertFacilityListModel.getNameQuery(),
      selectedJob: this.expertFacilityListModel.getSelectedJob(),
    };
  };

  public static setPageNumber = async (pageNumber: number) => {
    await this.expertFacilityListModel.setPageNumber(pageNumber);
    this.flush();
  };

  public static setNameQuery = async (nameQuery: string) => {
    await this.expertFacilityListModel.setNameQuery(nameQuery);
    this.flush();
  };

  public static setSelectedJob = async (job: EJob) => {
    await this.expertFacilityListModel.setSelectedJob(job);
    this.flush();
  };
}
