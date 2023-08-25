import { createApi } from "@reduxjs/toolkit/query/react";
import { TResponse, baseQueryWithReauth } from "./api";

export type TUser = {
  name: string;
};

export const userApiSlice = createApi({
  reducerPath: "api/user",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    getUser: builder.query<TUser, null>({
      query: () => "user",
      transformResponse: (response: TResponse) => {
        return response.data as TUser;
      },
    }),
  }),
});

export const { useGetUserQuery } = userApiSlice;
