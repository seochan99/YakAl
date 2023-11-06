import { EJob } from "@type/job.ts";

export type TExpertUser = {
  name: string | null;
  birthday: number[] | null;
  tel: string | null;
  job: EJob | null;
  department: string | null;
  belong: string | null;
  isOptionalAgreementAccepted: boolean | null;
  isIdentified: boolean;
};
