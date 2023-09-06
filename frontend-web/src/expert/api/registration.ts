import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";
import { EFacility } from "../type/facility.ts";
import { EInfoTake } from "../type/info-take.ts";

type TRegisterResponse = {
  registrationId: number;
};

type TRegisterRequest = {
  medicalType: EFacility;
  directorName: string;
  directorTel: string;
  medicalName: string;
  medicalTel: string;
  zipCode: string;
  medicalAddress: string;
  medicalDetailAddress: string;
  businessRegistrationNumber: string;
  reciveType: EInfoTake;
  medicalRuntime: string;
  medicalCharacteristics: string;
};

export const registrationApiSlice = createApi({
  reducerPath: "api/registration",
  baseQuery: baseQueryWithReauth,
  endpoints: (builder) => ({
    register: builder.mutation<TRegisterResponse, TRegisterRequest>({
      query: (requestBody: TRegisterRequest) => ({
        url: "medical/register",
        method: "POST",
        body: {
          ...requestBody,
        },
      }),
      transformResponse: (response: TResponse) => {
        return { registrationId: response.data as number };
      },
    }),
    registerImage: builder.mutation({
      query: ({ registerId, image }) => ({
        url: `image/medical?registerId=${registerId as number}`,
        method: "POST",
        formData: true,
        body: image as FormData,
      }),
      transformResponse: (response: TResponse) => {
        return { imagePath: (response.data as { uuid_name: string })?.uuid_name };
      },
    }),
  }),
});

export const { useRegisterMutation, useRegisterImageMutation } = registrationApiSlice;
