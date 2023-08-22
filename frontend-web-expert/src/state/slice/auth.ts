import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

export type TUser = {
  name: string;
};

export const userApi = createApi({
  reducerPath: "userApi",
  baseQuery: fetchBaseQuery({ baseUrl: import.meta.env.VITE_DEV_SERVER_HOST }),
  endpoints: (builder) => ({
    getUser: builder.query<TUser, null>({
      query: () => `user`,
    }),
  }),
});
