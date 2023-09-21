import { createBrowserRouter } from "react-router-dom";
import { MainPage as ExpertMain } from "../expert/page/main/view.tsx";
import { Main as AdminMain } from "../admin/layout/main";
import ErrorPage from "../expert/page/error/view.tsx";
import { Login as AdminLogin } from "../admin/page/login";
import { LoginPage as ExpertLogin } from "../expert/page/login/view.tsx";
import LoginMainPage from "../expert/page/login/children/main/view.tsx";
import TermsPage from "../expert/page/login/children/terms/view.tsx";

import PatientList from "../expert/page/main/children/patient-list";
import { Dashboard as ExpertDashboard } from "../expert/page/main/children/dashboard";
import { Dashboard as AdminDashboard } from "../admin/page/main/dashboard";
import PatientInfo from "../expert/page/main/children/patient-info";

import SocialLoginFailurePage from "../expert/page/login/children/social-login-failure/view.tsx";
import { loader as facilityRegistrationInfoLoader } from "../admin/page/main/facility-registration-info/loader.ts";
import { FacilityRegistration as AdminFacilityRegistration } from "../admin/page/main/facility-registration-list";
import { FacilityRegistration as ExpertFacilityRegistration } from "../expert/page/main/children/facility-registration";
import MyInfo from "../expert/page/main/children/my-info";
import SocialLogin from "../expert/page/login/children/social-login/view.tsx";
import LoadingPage from "../expert/page/loading/view.tsx";
import IdentifyPage from "../expert/page/login/children/identify/view.tsx";
import IdentifyFailurePage from "../expert/page/login/children/identify-failure/view.tsx";
import ExpertCertification from "../expert/page/main/children/expert-certification";
import IdentifySuccessPage from "../expert/page/login/children/identify-success/view.tsx";
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
                    element: <TermsPage />,
                  },
                  {
                    path: "social/failure",
                    element: <SocialLoginFailurePage />,
                  },
                  {
                    path: "social/kakao",
                    element: <SocialLogin />,
                  },
                  {
                    path: "social/google",
                    element: <SocialLogin />,
                  },
                  {
                    path: "identify",
                    element: <IdentifyPage />,
                  },
                  {
                    path: "identify/failure",
                    element: <IdentifyFailurePage />,
                  },
                  {
                    path: "identify/success",
                    element: <IdentifySuccessPage />,
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
