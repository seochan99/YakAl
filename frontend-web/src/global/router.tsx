import { createBrowserRouter } from "react-router-dom";
import { MainPage as ExpertMain } from "../expert/page/main";
import { Main as AdminMain } from "../admin/layout/main";
import ErrorPage from "../expert/page/error/view.tsx";
import { Login as AdminLogin } from "../admin/page/login";
import { LoginPage as ExpertLogin } from "../expert/page/login/view.tsx";
import LoginMainPage from "../expert/page/login/children/main/view.tsx";
import SignUpTerms from "../expert/page/login/children/signup-terms";

import PatientList from "../expert/page/main/children/patient-list";
import { Dashboard as ExpertDashboard } from "../expert/page/main/children/dashboard";
import { Dashboard as AdminDashboard } from "../admin/page/main/dashboard";
import PatientInfo from "../expert/page/main/children/patient-info";

import SocialLoginFailure from "../expert/page/login/children/social-login-failure";
import { loader as facilityRegistrationInfoLoader } from "../admin/page/main/facility-registration-info/loader.ts";
import { FacilityRegistration as AdminFacilityRegistration } from "../admin/page/main/facility-registration-list";
import { FacilityRegistration as ExpertFacilityRegistration } from "../expert/page/main/children/facility-registration";
import MyInfo from "../expert/page/main/children/my-info";
import SocialLoginProxy from "../expert/page/login/children/social-login-proxy";
import LoadingPage from "../expert/page/loading/view.tsx";
import IdentificationPage from "../expert/page/login/children/identification-page";
import IdentificationFailure from "../expert/page/login/children/identification-failure";
import ExpertCertification from "../expert/page/main/children/expert-certification";
import IdentificationSuccess from "../expert/page/login/children/identification-success";
import FacilityRegistrationInfo from "../admin/page/main/facility-registration-info";
import RegistrationSuccess from "../expert/page/main/children/registration-success";
import RegistrationFailure from "../expert/page/main/children/registration-failure";
import CertificationSuccess from "../expert/page/main/children/certification-success/index.tsx";
import CertificationFailure from "../expert/page/main/children/certification-failure";

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
                    path: "certification/success",
                    element: <CertificationSuccess />,
                  },
                  {
                    path: "certification/failure",
                    element: <CertificationFailure />,
                  },
                  {
                    path: "certification",
                    element: <ExpertCertification />,
                  },
                  {
                    path: "patient/:patientId",
                    element: <PatientInfo />,
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
                    element: <LoginMainPage />,
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
