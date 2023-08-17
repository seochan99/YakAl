import { createBrowserRouter } from "react-router-dom";
import Main from "@/layout/main";
import ErrorPage from "@/page/error";
import Login from "@/layout/login";
import { sidebarRouterMap } from "./sidebar-router";
import LoginMain from "@/page/login/login-main";

export const MAIN_DASHBOARD_ROUTE = "/";
export const LOGIN_ROUTE = "/login";

export const router = createBrowserRouter([
  {
    path: LOGIN_ROUTE,
    element: <Login />,
    errorElement: <ErrorPage />,
    children: [
      {
        index: true,
        element: <LoginMain />,
      },
    ],
  },
  {
    path: MAIN_DASHBOARD_ROUTE,
    element: <Main />,
    errorElement: <ErrorPage />,
    children: [
      {
        errorElement: <ErrorPage />,
        children: sidebarRouterMap.map((router) =>
          router.path == ""
            ? { index: true, element: <router.element /> }
            : { path: router.path, element: <router.element /> },
        ),
      },
    ],
  },
]);
