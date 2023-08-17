import { ThemeProvider } from "styled-components";
import { GlobalStyle } from "@/style/global-style.js";
import { theme } from "@/style/theme.js";
import { RouterProvider } from "react-router-dom";
import router from "@/router/router";
import { useEffect } from "react";
import { onSlientRefresh } from "./util/slient-refresh";

export default function App() {
  useEffect(() => {
    onSlientRefresh();
  }, []);

  return (
    <>
      <ThemeProvider theme={theme}>
        <GlobalStyle />
        <RouterProvider router={router} />
      </ThemeProvider>
    </>
  );
}
