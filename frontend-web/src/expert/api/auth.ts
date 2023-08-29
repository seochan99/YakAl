import { createApi } from "@reduxjs/toolkit/query/react";
import { TResponse, baseQueryWithReauth } from "./api.ts";

export type TLogout = {
  success: boolean;
};

export const authApiSlice = createApi({
  reducerPath: "api/auth",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    logout: builder.query<TLogout, null>({
      query: () => ({
        url: "auth/logout",
        method: "PATCH",
      }),
      transformResponse: (response: TResponse) => {
        return { success: response.success };
      },
    }),
  }),
});

export const { useLazyLogoutQuery } = authApiSlice;
