import { TUser, users } from "@/expert/store/user.ts";

export type TPatientInfoLoaderArgs = {
  patientId: string;
};

export type TPatientInfoLoaderReturn = {
  userInfo?: TUser;
};

export async function loader({ params }: { params: unknown }): Promise<TPatientInfoLoaderReturn> {
  const typesParams = params as TPatientInfoLoaderArgs;
  const userInfo = users.find((user) => user.id === +typesParams.patientId);
  return { userInfo };
}
