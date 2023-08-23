import { TResponse, apiSlice } from "./api";

export type TUser = {
  name: string;
};

export const userApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getUser: builder.query<TUser, null>({
      query: () => "user",
      transformResponse: (response: TResponse) => {
        return response.data as TUser;
      },
    }),
  }),
});

export const { useGetUserQuery } = userApiSlice;
