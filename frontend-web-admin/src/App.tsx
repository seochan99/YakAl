import { ThemeProvider } from "styled-components";
import { GlobalStyle } from "./style/globalStyle.js";
import { theme } from "./style/theme.js";
import Router from "./router.js";

export default function App() {
  // 프로그램 초기화 기다리기


  return (
    <>
        <ThemeProvider theme={theme}>
          <GlobalStyle />
              <Router />
        </ThemeProvider>
    </>
  );
}
