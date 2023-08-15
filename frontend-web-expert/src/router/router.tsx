import { createBrowserRouter } from "react-router-dom";
import Root from "@/layout/Root";
import ErrorPage from "@/pages/error-page";
import Login from "@/pages/login";
import { RouterType } from "./router-map-type";
import { routerMap } from "./router-map";

const router = createBrowserRouter([
  {
    path: "/login",
    element: <Login />,
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
