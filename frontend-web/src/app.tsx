import { RouterProvider } from "react-router-dom";
import { router } from "@/global/router.tsx";
import { Provider } from "react-redux";
import { store } from "@/expert/store/store";
import { CookiesProvider } from "react-cookie";
import { GlobalStyle } from "@/global/style/style.ts";
import { useEffect } from "react";

function App() {
  const pathname = window.location.pathname;

  useEffect(() => {
    if (pathname.startsWith("/expert")) {
      document.title = "약 알 - 전문가 WEB";
    } else {
      document.title = "약 알 - 관리자 WEB";
    }
  }, [pathname]);

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
