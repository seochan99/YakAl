import { createBrowserRouter } from "react-router-dom";
import Root from "@/layout/root";
import ErrorPage from "@/page/error-page";
import Login from "@/page/login";
import { RouterType } from "./router-map-type";
import { routerMap } from "./router-map";
import KakaoLogin from "@/page/kakao-login";

const router = createBrowserRouter([
  {
    path: "/login",
    element: <Login />,
    errorElement: <ErrorPage />,
  },
  {
    path: "/auth/kakao/callback",
    element: <KakaoLogin />,
    errorElement: <ErrorPage />,
  },
  {
    path: "/",
    element: <Root />,
    errorElement: <ErrorPage />,
    children: [
      {
        errorElement: <ErrorPage />,
        children: routerMap.map((router: RouterType) =>
          router.path == "/"
            ? { index: true, element: <router.element /> }
            : { path: router.path, element: <router.element /> },
        ),
      },
    ],
  },
]);

export default router;
