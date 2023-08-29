import { TUser, users } from "@/expert/store/user.ts";

export type TPatientLoaderReturn = {
  userList: TUser[];
};

export async function loader(): Promise<TPatientLoaderReturn> {
  return { userList: users };
}
