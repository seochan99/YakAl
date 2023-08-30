import { RouterProvider } from "react-router-dom";
import { router } from "@/global/router.tsx";
import { Provider } from "react-redux";
import { store } from "@/expert/store/store";
import { CookiesProvider } from "react-cookie";
import { GlobalStyle } from "@/global/style/style.ts";

function App() {
  return (
    <>
      <GlobalStyle />
      <CookiesProvider>
        <Provider store={store}>
          <RouterProvider router={router} />
        </Provider>
      </CookiesProvider>
    </>
  );
}

export default App;
