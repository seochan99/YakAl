import { ExpertUserViewModel } from "@page/main/view.model.ts";
import { EJob } from "@type/job.ts";

export const useMyPageViewController = () => {
  const { getExpertUser, isLoading } = ExpertUserViewModel;
  const { name, birthday, tel, job, department, belong } = getExpertUser() ?? {};

  const formattedBirthday = birthday
    ? `${birthday.getFullYear()}. ${
        birthday.getMonth() + 1 < 10 ? "0".concat((birthday.getMonth() + 1).toString()) : birthday.getMonth() + 1
      }. ${birthday.getDate() < 10 ? "0".concat(birthday.getDate().toString()) : birthday.getDate()}.`
    : "";

  const jobDetail: string | undefined =
    department && job ? department + " " + (job ? (job === EJob.DOCTOR ? "의사" : "약사") : "") : undefined;

  return { name, formattedBirthday, tel, jobDetail, belong, isLoading };
};
