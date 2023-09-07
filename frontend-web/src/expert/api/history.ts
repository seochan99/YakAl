import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

type THistory = {
  id: number;
  name: string;
};

export const historyApiSlice = createApi({
  reducerPath: "api/history",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    getHistory: builder.query<THistory[], { patientId: number }>({
      query: ({ patientId }) => `expert/patient/${patientId}/diagnosis`,
      transformResponse: (response: TResponse) => {
        return response.data as THistory[];
      },
    }),
  }),
});

export const { useGetHistoryQuery } = historyApiSlice;
