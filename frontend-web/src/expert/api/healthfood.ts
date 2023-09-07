import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

type THealth = {
  id: number;
  name: string;
};

export const healthApiSlice = createApi({
  reducerPath: "api/health",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    getHealthFood: builder.query<THealth[], { patientId: number }>({
      query: ({ patientId }) => `expert/patient/${patientId}/healthfood`,
      transformResponse: (response: TResponse) => {
        return response.data as THealth[];
      },
    }),
  }),
});

export const { useGetHealthFoodQuery } = healthApiSlice;
