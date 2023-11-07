import { EJob } from "@type/enum/job.ts";

export type TDenyReq = {
  isApproval: boolean;
  department: string;
  job: EJob | string;
};
