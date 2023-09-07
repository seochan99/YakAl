import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";
import { EFacility } from "../type/facility.ts";

type TFacilityResponse = {
  medicalList: TFacility[];
  totalCount: number;
};

export type TFacility = {
  id: number;
  medicalName: string;
  medicalAddress: string;
  medicalTel: string;
  medicalPoint: {
    latitude: number;
    longitude: number;
  };
  eMedical: EFacility;
  isRegister: boolean;
};

export const facilityListApiSlice = createApi({
  reducerPath: "api/facilityList",
  baseQuery: baseQueryWithReauth,
  tagTypes: ["FacilityList"],
  endpoints: (builder) => ({
    getFacilityList: builder.query<TFacilityResponse, { name: string; page: number; type: EFacility }>({
      query: ({ name, page, type }) =>
        `admin/medical/register/${
          type === EFacility.HOSPITAL ? "hospital" : "pharmacy"
        }?name=${name}&page=${page}&num=5`,
      transformResponse: (response: TResponse) => {
        return response.data as TFacilityResponse;
      },
      providesTags: ["FacilityList"],
    }),
  }),
});

export const { useGetFacilityListQuery } = facilityListApiSlice;
