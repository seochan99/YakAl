import { EJob } from "@type/enum/job.ts";

export type TProfileProps = {
  job: EJob | null;
  department: string | null;
  belong: string | null;
  name: string | null;
};
