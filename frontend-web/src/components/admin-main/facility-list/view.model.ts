import React, { useState } from "react";
import { AdminFacilityListModel } from "@store/admin-facility-list.ts";
import { EOrder } from "@type/order.ts";
import { EFacilityField } from "@type/facility-field.ts";

export class AdminFacilityListViewModel {
  private static updater: boolean;
  private static setState: React.Dispatch<React.SetStateAction<boolean>> | undefined;

  private static facilityListModel = AdminFacilityListModel.getInstance();

  private static flush = () => {
    if (this.setState === undefined) {
      return;
    }
    this.setState(!this.updater);
  };

  public static use = () => {
    [this.updater, this.setState] = useState(false);
  };

  public static fetch = async () => {
    this.facilityListModel.invalidate();
    this.flush();
    await this.facilityListModel.fetch();
    this.flush();
  };

  public static getStates = () => {
    return {
      isLoading: this.facilityListModel.isLoading(),
      facilityList: this.facilityListModel.getFacilityList(),
      paging: this.facilityListModel.getPagingInfo(),
      sorting: this.facilityListModel.getSortingInfo(),
      nameQuery: this.facilityListModel.getNameQuery(),
    };
  };

  public static setPageNumber = async (pageNumber: number) => {
    await this.facilityListModel.setPageNumber(pageNumber);
    this.flush();
  };

  public static setSortBy = async (order: EOrder, field: EFacilityField) => {
    await this.facilityListModel.setSortBy(order, field);
    this.flush();
  };

  public static setNameQuery = async (nameQuery: string) => {
    await this.facilityListModel.setNameQuery(nameQuery);
    this.flush();
  };
}
