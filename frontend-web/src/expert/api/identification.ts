import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "@/expert/api/api.ts";

type TIdentification = {
  isIdentified: boolean;
};

export const identificationApiSlice = createApi({
  reducerPath: "api/identification",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    checkIdentification: builder.query<TIdentification, null>({
      query: () => "user/check/identification",
      transformResponse: (response: TResponse) => {
        return { isIdentified: (response.data as { isIdentified: boolean })?.isIdentified };
      },
    }),
  }),
});

export const { useCheckIdentificationQuery } = identificationApiSlice;
