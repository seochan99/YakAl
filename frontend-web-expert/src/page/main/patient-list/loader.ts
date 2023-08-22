import { TUser, users } from "@/uiui/user";

export type TPatientLoaderReturn = {
  userList: TUser[];
};

export async function loader(): Promise<TPatientLoaderReturn> {
  return { userList: users };
}
