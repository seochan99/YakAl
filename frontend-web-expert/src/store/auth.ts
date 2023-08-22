import { createSlice } from "@reduxjs/toolkit";
import { RootState } from "./store";

export type TUser = {
  name: string;
};

const authSlice = createSlice({
  name: "auth",
  initialState: { user: null, token: null } as { user: TUser | null; token: string | null },
  reducers: {
    setCredentials: (state, action) => {
      const { user, token } = action.payload;
      state.user = user;
      state.token = token;
    },
    logout: (state) => {
      state.user = null;
      state.token = null;
    },
  },
});

export const { setCredentials, logout } = authSlice.actions;

export default authSlice.reducer;

export const selectCurrentUser = (state: RootState) => state.auth.user;
export const selectCurrentToken = (state: RootState) => state.auth.token;
