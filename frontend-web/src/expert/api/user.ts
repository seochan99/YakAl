import { createApi } from "@reduxjs/toolkit/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";
import { EJob } from "@/expert/type/job.ts";

export type TUser = {
  name: string;
  birthday: Date;
  tel: string;
  job?: EJob;
  department?: string;
  belong?: string;
};

export const userApiSlice = createApi({
  reducerPath: "api/expert",
  baseQuery: baseQueryWithReauth,
  tagTypes: ["Expert"],
  endpoints: (builder) => ({
    getUser: builder.query<TUser, null>({
      query: () => "expert",
      transformResponse: (response: TResponse) => {
        const data = response.data as {
          name: string;
          birthday: number[];
          tel: string;
          job?: string;
          department?: string;
          belong?: string;
        };

        return {
          name: data.name,
          birthday: new Date(data.birthday[0], data.birthday[1] - 1, data.birthday[2]),
          tel: data.tel,
          job: EJob[data.job as keyof typeof EJob],
          department: data.department,
          belong: data.belong,
        };
      },
      providesTags: ["Expert"],
    }),
    identify: builder.mutation<TUser, string>({
      query: (impUid: string) => ({
        url: "user/identify",
        method: "PATCH",
        body: {
          impUid: `${impUid}`,
        },
      }),
      invalidatesTags: ["Expert"],
    }),
  }),
});

export const { useGetUserQuery, useIdentifyMutation } = userApiSlice;
