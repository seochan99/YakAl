import { createBrowserRouter } from "react-router-dom";
import Main from "@/expert/layout/main";
import ErrorPage from "@/expert/page/error-page";
import { Login as ExpertLogin } from "@/expert/layout/login";
import { Login as AdminLogin } from "../admin/page/login";
import LoginMain from "@/expert/page/login/login-main";
import SignUpTerms from "@/expert/page/login/signup-terms";

import PatientList from "@/expert/page/main/patient-list";
import Dashboard from "@/expert/page/main/dashboard";
import PatientInfo from "@/expert/page/main/patient-info";

import SocialLoginFailure from "@/expert/page/login/social-login-failure";
import { loader as patientLoader } from "@/expert/page/main/patient-list/loader.ts";
import { loader as patientInfoLoader } from "@/expert/page/main/patient-info/loader.ts";
import Registration from "@/expert/page/main/registration";
import Certification from "@/expert/page/main/certification";
import MyInfo from "@/expert/page/main/my-info";
import SocialLoginProxy from "@/expert/page/login/social-login-proxy";
import LoadingPage from "@/expert/page/loading-page";
import IdentificationPage from "@/expert/page/login/identification-page";
import IdentificationFailure from "@/expert/page/login/identification-failure";

export const EXPERT_LOGIN_ROUTE = "/expert/login";
export const ADMIN_LOGIN_ROUTE = "/admin/login";

export const router = createBrowserRouter([
  {
    errorElement: <ErrorPage />,
    children: [
      {
        path: "/admin",
        errorElement: <ErrorPage />,
        children: [
          {
            path: "login",
            element: <AdminLogin />,
            errorElement: <ErrorPage />,
          },
        ],
      },
      {
        path: "/expert",
        errorElement: <ErrorPage />,
        children: [
          {
            path: "login",
            element: <ExpertLogin />,
            errorElement: <ErrorPage />,
            children: [
              {
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
                  {
                    path: "social/failure",
                    element: <SocialLoginFailure />,
                  },
                  {
                    path: "social/kakao",
                    element: <SocialLoginProxy />,
                  },
                  {
                    path: "social/google",
                    element: <SocialLoginProxy />,
                  },
                  {
                    path: "identification",
                    element: <IdentificationPage />,
                  },
                  {
                    path: "identification/failure",
                    element: <IdentificationFailure />,
                  },
                ],
              },
            ],
          },
          {
            path: "loading",
            element: <LoadingPage />,
            errorElement: <ErrorPage />,
          },
          {
            path: "",
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
        ],
      },
    ],
  },
]);
