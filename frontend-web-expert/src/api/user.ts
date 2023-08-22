import { TUser } from "@/store/auth";
import { apiSlice } from "./api";

export const userApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getUser: builder.query<TUser, void>({
      query: () => "user",
    }),
  }),
});

export const { useGetUserQuery } = userApiSlice;
