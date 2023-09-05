import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "@/expert/api/api.ts";

type TIdentification = {
  isIdentified: boolean;
};

export const registrationApiSlice = createApi({
  reducerPath: "api/registration",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    checkIdentification: builder.query<TIdentification, null>({
      query: () => ({
        path: "medical/register",
        method: "POST",
      }),
      transformResponse: (response: TResponse) => {
        return { isIdentified: (response.data as { isIdentified: boolean })?.isIdentified };
      },
    }),
  }),
});

export const { useCheckIdentificationQuery } = registrationApiSlice;
