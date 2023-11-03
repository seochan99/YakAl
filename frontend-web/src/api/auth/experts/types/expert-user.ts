import { EJob } from "@type/job.ts";

export type TExpertUser = {
  name: string;
  birthday: number[];
  tel: string;
  job: EJob | null;
  department: string | null;
  belong: string | null;
};
