import { TUser, users } from "@/state/user";

export type TPatientLoaderReturn = {
  userList: TUser[];
};

export async function loader(): Promise<TPatientLoaderReturn> {
  return { userList: users };
}
