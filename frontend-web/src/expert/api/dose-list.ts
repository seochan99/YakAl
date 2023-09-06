import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

type TDoseListResponse = {
  prescribedList: TDoseList[];
  totalCount: number;
};

export type TDoseList = {
  kdcode: string;
  score: number;
  prescribedDate: number[];
};

export const doseListApiSlice = createApi({
  reducerPath: "api/doseList",
  baseQuery: baseQueryWithReauth,
  tagTypes: ["DoseList"],
  endpoints: (builder) => ({
    getDoseList: builder.query<TDoseListResponse, { patientId: number; page: number; period: string }>({
      query: ({ patientId, page, period }) => ({
        url: `expert/patient/${patientId}/dose?page=${page}&num=5&period=${period}`,
        method: "GET",
      }),
      transformResponse: (response: TResponse) => {
        return response.data as TDoseListResponse;
      },
      providesTags: ["DoseList"],
    }),
  }),
});

export const { useGetDoseListQuery } = doseListApiSlice;
