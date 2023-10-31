import { EJob } from "@type/job.ts";

export type TExpertUser = {
  name: string;
  birthday: Date;
  tel: string;
  job: EJob;
  department: string;
  belong: string;
};

const expertUser: TExpertUser = {
  name: "홍길동",
  birthday: new Date("1998-01-01"),
  tel: "010-9999-9999",
  job: EJob.DOCTOR,
  department: "가정의학과",
  belong: "중앙대학교광명병원",
};

export class ExpertUserModel {
  /* PRIVATE MEMBER VARIABLE */
  private expertUser: TExpertUser | null = null;

  /* SINGLETON */
  private static instance: ExpertUserModel | null = null;

  private constructor() {
    return;
  }

  public static getInstance = () => {
    if (ExpertUserModel.instance !== null) {
      return ExpertUserModel.instance;
    }

    ExpertUserModel.instance = new ExpertUserModel();
    return ExpertUserModel.instance;
  };

  /* PUBLIC METHOD */
  // public fetch = async (expertId: number) => {
  public fetch = async () => {
    this.expertUser = null;

    // Dummy async communication
    this.expertUser = expertUser;
  };

  public invalidate = () => {
    this.expertUser = null;
  };

  public isLoading = () => this.expertUser == null;

  public getExpertUser = () => this.expertUser;
}
