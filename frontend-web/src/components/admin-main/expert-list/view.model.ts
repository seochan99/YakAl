import React, { useState } from "react";
import { EOrder } from "@type/order.ts";
import { AdminExpertListModel } from "@store/admin-expert-list.ts";
import { EExpertField } from "@type/expert-field.ts";

export class AdminExpertListViewModel {
  private static updater: boolean;
  private static setState: React.Dispatch<React.SetStateAction<boolean>> | undefined;

  private static expertListModel = AdminExpertListModel.getInstance();

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
    await this.expertListModel.fetch();
    this.flush();
  };

  public static getStates = () => {
    return {
      isLoading: this.expertListModel.isLoading(),
      expertList: this.expertListModel.getExpertList(),
      paging: this.expertListModel.getPagingInfo(),
      sorting: this.expertListModel.getSortingInfo(),
      nameQuery: this.expertListModel.getNameQuery(),
    };
  };

  public static setPageNumber = async (pageNumber: number) => {
    await this.expertListModel.setPageNumber(pageNumber);
    this.flush();
  };

  public static setSortBy = async (order: EOrder, field: EExpertField) => {
    await this.expertListModel.setSortBy(order, field);
    this.flush();
  };

  public static setNameQuery = async (nameQuery: string) => {
    await this.expertListModel.setNameQuery(nameQuery);
    this.flush();
  };
}
