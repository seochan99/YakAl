import React, { useState } from "react";
import { PatientListModel } from "@store/patient-list.ts";
import { EOrder } from "@type/enum/order.ts";
import { EPatientField } from "@type/enum/patient-field.ts";

export class PatientListViewModel {
  private static updater: boolean;
  private static setState: React.Dispatch<React.SetStateAction<boolean>> | undefined;

  private static patientListModel = PatientListModel.getInstance();

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
    await this.patientListModel.fetch();
    this.flush();
  };

  public static getStates = () => {
    const patientList = this.patientListModel.getPatientList();

    return {
      isLoading: this.patientListModel.isLoading(),
      isEmpty: patientList ? patientList.length === 0 : 0,
      patientList,
      paging: this.patientListModel.getPagingInfo(),
      sorting: this.patientListModel.getSortingInfo(),
      nameQuery: this.patientListModel.getNameQuery(),
      isOnlyManaged: this.patientListModel.getIsOnlyManaged(),
    };
  };

  public static setPageNumber = async (pageNumber: number) => {
    await this.patientListModel.setPageNumber(pageNumber);
    this.flush();
  };

  public static setSortBy = async (order: EOrder, field: EPatientField) => {
    await this.patientListModel.setSortBy(order, field);
    this.flush();
  };

  public static setNameQuery = async (nameQuery: string) => {
    await this.patientListModel.setNameQuery(nameQuery);
    this.flush();
  };

  public static setIsOnlyManaged = async (isOnlyManaged: boolean) => {
    await this.patientListModel.setIsOnlyManaged(isOnlyManaged);
    this.flush();
  };

  public static setIsManaged = async (patientId: number) => {
    await this.patientListModel.toggleIsManaged(patientId);
    this.flush();
  };
}
