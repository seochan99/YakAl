import { EJob } from "@type/enum/job.ts";

export type TAdminExpertItem = {
  id: number;
  type: EJob | string;
  name: string;
  requestedAt: number[];
  tel: string;
  belong: string;
};
