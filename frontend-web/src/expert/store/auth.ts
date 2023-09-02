import { createSlice } from "@reduxjs/toolkit";
import { RootState } from "./store.ts";

export const authSlice = createSlice({
  name: "auth",
  initialState: { token: null } as { token: string | null },
  reducers: {
    setCredentials: (state, action) => {
      const { token } = action.payload;
      state.token = token;
    },
    logout: (state) => {
      state.token = null;
    },
  },
});

export const { setCredentials, logout } = authSlice.actions;

export const selectCurrentToken = (state: RootState) => state.auth.token;
