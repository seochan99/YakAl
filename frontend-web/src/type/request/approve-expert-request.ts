import { EJob } from "@type/enum/job.ts";

export type TApproveExpertRequest = {
  isApproval: boolean;
  department: string;
  job: EJob | string;
};
