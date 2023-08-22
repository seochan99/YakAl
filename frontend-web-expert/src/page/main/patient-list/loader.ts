import { TUser, users } from "@/store/user";

export type TPatientLoaderReturn = {
  userList: TUser[];
};

export async function loader(): Promise<TPatientLoaderReturn> {
  return { userList: users };
}
