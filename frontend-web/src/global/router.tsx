import { createBrowserRouter } from "react-router-dom";
import { Main as ExpertMain } from "@/expert/layout/main";
import { Main as AdminMain } from "@/admin/layout/main";
import ErrorPage from "@/expert/page/error-page";
import { Login as ExpertLogin } from "@/expert/layout/login";
import { Login as AdminLogin } from "../admin/page/login";
import LoginMain from "@/expert/page/login/login-main";
import SignUpTerms from "@/expert/page/login/signup-terms";

import PatientList from "@/expert/page/main/patient-list";
import { Dashboard as ExpertDashboard } from "@/expert/page/main/dashboard";
import { Dashboard as AdminDashboard } from "@/admin/page/main/dashboard";
import PatientInfo from "@/expert/page/main/patient-info";

import SocialLoginFailure from "@/expert/page/login/social-login-failure";
import { loader as patientLoader } from "@/expert/page/main/patient-list/loader.ts";
import { loader as patientInfoLoader } from "@/expert/page/main/patient-info/loader.ts";
import { loader as facilityRegistrationInfoLoader } from "@/admin/page/main/facility-registration-info/loader.ts";
import { FacilityRegistration as AdminFacilityRegistration } from "../admin/page/main/facility-registration-list";
import { FacilityRegistration as ExpertFacilityRegistration } from "../expert/page/main/facility-registration";
import MyInfo from "@/expert/page/main/my-info";
import SocialLoginProxy from "@/expert/page/login/social-login-proxy";
import LoadingPage from "@/expert/page/loading-page";
import IdentificationPage from "@/expert/page/login/identification-page";
import IdentificationFailure from "@/expert/page/login/identification-failure";
import ExpertCertification from "@/expert/page/main/expert-certification";
import IdentificationSuccess from "@/expert/page/login/identification-success";
import FacilityRegistrationInfo from "@/admin/page/main/facility-registration-info";
import RegistrationSuccess from "@/expert/page/main/registration-success";
import RegistrationFailure from "@/expert/page/main/registration-failure";

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
            path: "",
            element: <AdminMain />,
            errorElement: <ErrorPage />,
            children: [
              {
                index: true,
                element: <AdminDashboard />,
              },
              {
                path: "partner/facility-registration",
                element: <AdminFacilityRegistration />,
              },
              {
                path: "partner/facility-registration/:facilityId",
                element: <FacilityRegistrationInfo />,
                loader: facilityRegistrationInfoLoader,
              },
            ],
          },
          {
            path: "login",
            element: <AdminLogin />,
          },
        ],
      },
      {
        path: "/expert",
        errorElement: <ErrorPage />,
        children: [
          {
            path: "",
            element: <ExpertMain />,
            errorElement: <ErrorPage />,
            children: [
              {
                errorElement: <ErrorPage />,
                children: [
                  {
                    index: true,
                    element: <ExpertDashboard />,
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
                    element: <ExpertFacilityRegistration />,
                  },
                  {
                    path: "registration/success",
                    element: <RegistrationSuccess />,
                  },
                  {
                    path: "registration/failure",
                    element: <RegistrationFailure />,
                  },
                  {
                    path: "certification",
                    element: <ExpertCertification />,
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
                  {
                    path: "identification/success",
                    element: <IdentificationSuccess />,
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
        ],
      },
    ],
  },
]);
