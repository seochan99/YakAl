import { configureStore } from "@reduxjs/toolkit";
import { setupListeners } from "@reduxjs/toolkit/dist/query";
import { authSlice } from "./auth.ts";
import { userApiSlice } from "@/expert/api/user.ts";
import { authApiSlice } from "@/expert/api/auth.ts";
import { identificationApiSlice } from "@/expert/api/identification.ts";
import { registrationApiSlice } from "@/expert/api/registration.ts";

export const store = configureStore({
  reducer: {
    [userApiSlice.reducerPath]: userApiSlice.reducer,
    [authApiSlice.reducerPath]: authApiSlice.reducer,
    [identificationApiSlice.reducerPath]: identificationApiSlice.reducer,
    [registrationApiSlice.reducerPath]: registrationApiSlice.reducer,
    [authSlice.name]: authSlice.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ serializableCheck: false }).concat(
      userApiSlice.middleware,
      authApiSlice.middleware,
      identificationApiSlice.middleware,
      registrationApiSlice.middleware,
    ),
  devTools: true,
});

setupListeners(store.dispatch);

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
