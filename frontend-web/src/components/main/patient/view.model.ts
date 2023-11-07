import { PatientModel } from "@store/patient.ts";
import React, { useState } from "react";
import { EPatientInfoTab } from "@type/enum/patient-info-tab.ts";

export class PatientPageViewModel {
  private static updater = false;
  private static setState: React.Dispatch<React.SetStateAction<boolean>>;

  private static patientPageModel = PatientModel;

  private static flush = () => {
    if (this.setState === undefined) {
      return;
    }
    this.setState(!this.updater);
  };

  public static use = () => {
    [this.updater, this.setState] = useState<boolean>(false);
  };

  public static fetchBase = async (patientId: number) => {
    this.patientPageModel.invalidateBase();
    this.flush();
    await this.patientPageModel.fetchBase(patientId);
    this.flush();
  };

  public static fetchProtector = async (patientId: number) => {
    this.patientPageModel.invalidateProtector();
    this.flush();
    await this.patientPageModel.fetchProtector(patientId);
    this.flush();
  };

  public static fetchETC = async (patientId: number) => {
    this.patientPageModel.invalidateETC();
    this.flush();
    await this.patientPageModel.fetchETC(patientId);
    this.flush();
  };

  public static fetchLastETC = async (patientId: number) => {
    this.patientPageModel.invalidateETC();
    this.flush();
    await this.patientPageModel.fetchLastETC(patientId);
    this.flush();
  };

  public static fetchBeersList = async (patientId: number) => {
    this.patientPageModel.invalidateBeersList();
    this.flush();
    await this.patientPageModel.fetchBeersList(patientId);
    this.flush();
  };

  public static fetchAnticholinergic = async (patientId: number) => {
    this.patientPageModel.invalidateAnticholinergic();
    this.flush();
    await this.patientPageModel.fetchAnticholinergic(patientId);
    this.flush();
  };

  public static fetchARMS = async (patientId: number) => {
    this.patientPageModel.invalidateARMS();
    this.flush();
    await this.patientPageModel.fetchARMS(patientId);
    this.flush();
  };

  public static fetchGeriatricSyndrome = async (patientId: number) => {
    this.patientPageModel.invalidateGeriatricSyndrome();
    this.flush();
    await this.patientPageModel.fetchGeriatricSyndrome(patientId);
    this.flush();
  };

  public static fetchScreening = async (patientId: number) => {
    this.patientPageModel.invalidateScreening();
    this.flush();
    await this.patientPageModel.fetchScreening(patientId);
    this.flush();
  };

  public static getStates = () => {
    return {
      isLoading: this.patientPageModel.isLoading(),
      patientInfo: this.patientPageModel.getPatientInfo(),
      currentTab: this.patientPageModel.getCurrentTab(),
      tabInfos: this.patientPageModel.getTabInfos(),
    };
  };

  public static setCurrentTab = async (tab: EPatientInfoTab) => {
    await this.patientPageModel.setCurrentTab(tab);
    this.flush();
  };

  public static setETCPage = async (page: number, patientId: number) => {
    this.patientPageModel.invalidateETC();
    this.flush();
    await this.patientPageModel.setETCPage(page, patientId);
    this.flush();
  };

  public static setBeersListPage = async (page: number, patientId: number) => {
    this.patientPageModel.invalidateBeersList();
    this.flush();
    await this.patientPageModel.setBeersListPage(page, patientId);
    this.flush();
  };

  public static setAnticholinergicDrugsPage = async (page: number, patientId: number) => {
    this.patientPageModel.invalidateAnticholinergic();
    this.flush();
    await this.patientPageModel.setAnticholinergicDrugsPage(page, patientId);
    this.flush();
  };
}
