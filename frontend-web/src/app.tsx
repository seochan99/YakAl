import { ThemeProvider } from "styled-components";
import { GlobalStyle } from "@/expert/style/global-style.js";
import { theme } from "@/expert/style/theme.js";
import { RouterProvider } from "react-router-dom";
import { router } from "@/expert/router/router";
import { Provider } from "react-redux";
import { store } from "@/expert/store/store";
import { CookiesProvider } from "react-cookie";

function App() {
  return (
    <>
      <ThemeProvider theme={theme}>
        <GlobalStyle />
        <CookiesProvider>
          <Provider store={store}>
            <RouterProvider router={router} />
          </Provider>
        </CookiesProvider>
      </ThemeProvider>
    </>
  );
}

export default App;
