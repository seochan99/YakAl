import { createApi } from "@reduxjs/toolkit/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

export type TUser = {
  name: string;
  birthday: Date;
  tel: string;
};

export const userApiSlice = createApi({
  reducerPath: "api/user",
  baseQuery: baseQueryWithReauth,
  tagTypes: ["User"],
  endpoints: (builder) => ({
    getUser: builder.query<TUser, null>({
      query: () => "user",
      transformResponse: (response: TResponse) => {
        const data = response.data as {
          name: string;
          birthday: number[];
          tel: string;
        };

        return {
          name: data.name,
          birthday: new Date(data.birthday[0], data.birthday[1] - 1, data.birthday[2]),
          tel: data.tel,
        };
      },
      providesTags: ["User"],
    }),
    identify: builder.mutation<TUser, string>({
      query: (impUid: string) => ({
        url: "user/identify",
        method: "PATCH",
        body: {
          impUid: `${impUid}`,
        },
      }),
      invalidatesTags: ["User"],
    }),
  }),
});

export const { useGetUserQuery, useIdentifyMutation } = userApiSlice;
