import { RouterProvider } from "react-router-dom";
import { CookiesProvider } from "react-cookie";
import { useEffect } from "react";
import { router } from "./global/router.tsx";
import { GlobalStyle } from "./global/style/style.ts";

function App() {
  /* Dynamic page title */
  const pathname = window.location.pathname;

  useEffect(() => {
    if (pathname.startsWith("/expert")) {
      document.title = "약 알 - 전문가 WEB";
    } else {
      document.title = "약 알 - 관리자 WEB";
    }
  }, [pathname]);

  /* iOS Viewport Bug Fix */
  useEffect(() => {
    const handleResize = () => {
      const vh = window.innerHeight * 0.01;
      document.documentElement.style.setProperty("--vh", `${vh}px`);
    };

    handleResize();
    window.addEventListener("resize", handleResize);

    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return (
    <>
      <GlobalStyle />
      <CookiesProvider>
        <RouterProvider router={router} />
      </CookiesProvider>
    </>
  );
}

export default App;
