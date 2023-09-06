import { configureStore } from "@reduxjs/toolkit";
import { setupListeners } from "@reduxjs/toolkit/dist/query";
import { authSlice } from "./auth.ts";
import { userApiSlice } from "../api/user.ts";
import { authApiSlice } from "../api/auth.ts";
import { identificationApiSlice } from "../api/identification.ts";
import { registrationApiSlice } from "../api/registration.ts";
import { patientListApiSlice } from "../api/patient-list.ts";
import { noteListApiSlice } from "../api/note-list.ts";

export const store = configureStore({
  reducer: {
    [userApiSlice.reducerPath]: userApiSlice.reducer,
    [authApiSlice.reducerPath]: authApiSlice.reducer,
    [identificationApiSlice.reducerPath]: identificationApiSlice.reducer,
    [registrationApiSlice.reducerPath]: registrationApiSlice.reducer,
    [patientListApiSlice.reducerPath]: patientListApiSlice.reducer,
    [noteListApiSlice.reducerPath]: noteListApiSlice.reducer,
    [authSlice.name]: authSlice.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ serializableCheck: false }).concat(
      userApiSlice.middleware,
      authApiSlice.middleware,
      identificationApiSlice.middleware,
      registrationApiSlice.middleware,
      patientListApiSlice.middleware,
      noteListApiSlice.middleware,
    ),
  devTools: true,
});

setupListeners(store.dispatch);

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
