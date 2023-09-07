import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

type TSurveyResult = { datalist: TSurveyResultItem[]; percent: number };

type TSurveyResultItem = {
  title: string;
  result: number;
};

export const surveyResultApiSlice = createApi({
  reducerPath: "api/survey",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    getSurveyResult: builder.query<TSurveyResult, { patientId: number }>({
      query: ({ patientId }) => ({
        url: `/expert/patient/${patientId}/surbey`,
        method: "GET",
      }),
      transformResponse: (response: TResponse) => {
        return response.data as TSurveyResult;
      },
    }),
  }),
});

export const { useGetSurveyResultQuery } = surveyResultApiSlice;
