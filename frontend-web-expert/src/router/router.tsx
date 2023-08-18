import { createBrowserRouter } from "react-router-dom";
import Main from "@/layout/main";
import ErrorPage from "@/page/error";
import Login from "@/layout/login";
import LoginMain from "@/page/login/login-main";
import SignUpTerms from "@/page/login/signup-terms";

import Facility from "@/page/main/facility";
import Patient from "@/page/main/patient";
import Cohort from "@/page/main/cohort";
import Dashboard from "@/page/main/dashboard";
import PatientInfo from "@/component/patient-info";
import SelectPatient from "@/component/select-patient";

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
            path: "facility",
            element: <Facility />,
          },
          {
            path: "patient",
            element: <Patient />,
            children: [
              { index: true, element: <SelectPatient /> },
              {
                path: ":patientId",
                element: <PatientInfo />,
                loader: async ({ params }) => {
                  return { patientId: params.patientId };
                },
              },
            ],
          },
          {
            path: "cohort",
            element: <Cohort />,
          },
        ],
      },
    ],
  },
]);
