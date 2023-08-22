import { BaseQueryApi, FetchArgs, createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import { setCredentials, logout } from "@/store/auth";
import { RootState } from "@/store/store";
import { HttpStatusCode } from "axios";

const baseQuery = fetchBaseQuery({
  baseUrl: import.meta.env.VITE_DEV_SERVER_HOST,
  credentials: "include",
  prepareHeaders: (headers, { getState }) => {
    const state = getState() as RootState;
    const token = state.auth.token;

    if (token) {
      headers.set("authorization", `Bearer ${token}`);
    }
    return headers;
  },
});

const baseQueryWithReauth = async (args: FetchArgs, api: BaseQueryApi, extraOptions: Record<string, never>) => {
  let result = await baseQuery(args, api, extraOptions);

  if (result?.error?.status === HttpStatusCode.Unauthorized) {
    window.location.href = "/login";
  }

  if (result?.error?.status === HttpStatusCode.Forbidden) {
    const reissueResult = await baseQuery({ url: "/auth/reissue/secure", method: "POST" }, api, extraOptions);

    if (reissueResult?.error?.status !== HttpStatusCode.Created) {
      const state = api.getState() as RootState;
      const user = state.auth.user;

      api.dispatch(setCredentials({ token: (reissueResult.data as { accessToken: string }).accessToken, user }));

      result = await baseQuery(args, api, extraOptions);
    } else {
      api.dispatch(logout());
      window.location.href = "/login";
    }
  }

  return result;
};

export const apiSlice = createApi({
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({}),
});
