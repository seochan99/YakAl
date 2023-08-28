import { fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import { setCredentials, logout } from "@/store/auth";
import { RootState } from "@/store/store";
import { HttpStatusCode } from "axios";

export type TResponse = {
  success: boolean;
  data: object | null;
  error: object | null;
};

const baseQuery = fetchBaseQuery({
  baseUrl: import.meta.env.VITE_SERVER_HOST,
  credentials: "include",
  prepareHeaders: (headers, { getState }) => {
    const state = getState() as RootState;
    const token = state.auth.token;

    if (token) {
      headers.set("Authorization", `Bearer ${token}`);
    }

    return headers;
  },
});

export const baseQueryWithReauth = async (args: any, api: any, extraOptions: any) => {
  let result = await baseQuery(args, api, extraOptions);

  const resultHttpStatus = result?.meta?.response?.status;

  console.log(resultHttpStatus);

  if (resultHttpStatus === HttpStatusCode.Unauthorized || resultHttpStatus === HttpStatusCode.Forbidden) {
    const reissueResult = await baseQuery({ url: "/auth/reissue/secure", method: "POST" }, api, extraOptions);

    type TReissueResult = {
      success: boolean;
      data: {
        accessToken: string;
      };
      error?: object;
    };

    const reissueResultHttpStatus = reissueResult?.meta?.response?.status;

    if (reissueResultHttpStatus !== HttpStatusCode.Created) {
      api.dispatch(logout());

      console.log(reissueResult);
      // window.location.href = "/login";
    } else {
      api.dispatch(setCredentials({ token: (reissueResult.data as TReissueResult).data.accessToken }));
      result = await baseQuery(args, api, extraOptions);
    }
  }

  return result;
};
