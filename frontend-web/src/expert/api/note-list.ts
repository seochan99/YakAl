import { createApi } from "@reduxjs/toolkit/dist/query/react";
import { baseQueryWithReauth, TResponse } from "./api.ts";

type TNoteList = {
  datalist: TNoteItem[];
  pageInfo: {
    page: number;
    size: number;
    totalElements: number;
    totalPages: number;
  };
};

export type TNoteItem = {
  id: number;
  title: string;
  description: string;
  createDate: number[];
};

export const noteListApiSlice = createApi({
  reducerPath: "api/noteList",
  baseQuery: baseQueryWithReauth,
  tagTypes: ["NoteList"],
  endpoints: (builder) => ({
    getNoteList: builder.query<TNoteList, { patientId: number; page: number }>({
      query: ({ patientId, page }) => ({
        url: `expert/patient/${patientId}/note?page=${page}&num=5`,
        method: "GET",
      }),
      transformResponse: (response: TResponse) => {
        return response.data as TNoteList;
      },
      providesTags: ["NoteList"],
    }),
    createNote: builder.mutation<TNoteList, { patientId: number; title: string; description: string }>({
      query: ({ patientId, title, description }) => ({
        url: `expert/patient/${patientId}/note`,
        method: "POST",
        body: { title, description },
      }),
      invalidatesTags: ["NoteList"],
    }),
    modifyNote: builder.mutation<TNoteList, { noteId: number; title: string; description: string }>({
      query: ({ noteId, title, description }) => ({
        url: `expert/note/${noteId}`,
        method: "PUT",
        body: { title, description },
      }),
      invalidatesTags: ["NoteList"],
    }),
    deleteNote: builder.mutation<TNoteList, { noteId: number }>({
      query: ({ noteId }) => ({
        url: `expert/note/${noteId}`,
        method: "DELETE",
      }),
      invalidatesTags: ["NoteList"],
    }),
  }),
});

export const { useGetNoteListQuery, useCreateNoteMutation, useModifyNoteMutation, useDeleteNoteMutation } =
  noteListApiSlice;
