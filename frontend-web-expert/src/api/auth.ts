import { TResponse, apiSlice } from "./api";

export type TLogout = {
  success: boolean;
};

export const authAPiSlice = apiSlice.injectEndpoints({
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

export const { useLazyLogoutQuery } = authAPiSlice;
