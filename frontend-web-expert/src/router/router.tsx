import { createBrowserRouter } from "react-router-dom";
import Main from "@/layout/main";
import ErrorPage from "@/page/error";
import Login from "@/layout/login";
import LoginMain from "@/page/login/login-main";
import SignUpTerms from "@/page/login/signup-terms";

import PatientList from "@/page/main/patient-list";
import Dashboard from "@/page/main/dashboard";
import PatientInfo from "@/page/main/patient-info";

import { loader as patientLoader } from "@/page/main/patient-list/loader";
import { loader as patientInfoLoader } from "@/page/main/patient-info/loader";
import Registration from "@/page/main/registration";
import Certification from "@/page/main/certification";
import MyInfo from "@/page/main/my-info";
import KakaoLogin from "@/page/login/kakao-login";

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
      {
        path: "terms",
        element: <SignUpTerms />,
      },
    ],
  },
  {
    path: "/auth/kakao",
    element: <KakaoLogin />,
    errorElement: <ErrorPage />,
  },
  {
    path: MAIN_DASHBOARD_ROUTE,
    element: <Main />,
    errorElement: <ErrorPage />,
    children: [
      {
        errorElement: <ErrorPage />,
        children: [
          {
            index: true,
            element: <Dashboard />,
          },
          {
            path: "info",
            element: <MyInfo />,
          },
          {
            path: "patient",
            element: <PatientList />,
            loader: patientLoader,
          },
          {
            path: "registration",
            element: <Registration />,
          },
          {
            path: "certification",
            element: <Certification />,
          },
          {
            path: "patient/:patientId",
            element: <PatientInfo />,
            loader: patientInfoLoader,
          },
        ],
      },
    ],
  },
]);
