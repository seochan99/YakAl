import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

export type TPatientListResponse = {
  datalist: {
    id: number;
    name: string;
    sex: string;
    birthday: number[];
    testProgress: number;
    lastSurbey: number[];
  }[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};

export const patientListApiSlice = createApi({
  reducerPath: "api/patient/list",
  baseQuery: baseQueryWithReauth,
  tagTypes: ["PatientList"],
  endpoints: (builder) => ({
    getPatientList: builder.query<TPatientListResponse, { name: string; sort: string; order: string; page: number }>({
      query: ({ name, sort, order, page }) =>
        name.length !== 0
          ? {
              url: `expert/patient/name?name=${name}&sort=${sort}&order=${order}&page=${page}&num=10`,
            }
          : {
              url: `expert/patient?sort=${sort}&order=${order}&page=${page}&num=10`,
            },
      transformResponse: (response: TResponse) => {
        return response.data as TPatientListResponse;
      },
      providesTags: ["PatientList"],
    }),
  }),
});

export const { useGetPatientListQuery } = patientListApiSlice;
