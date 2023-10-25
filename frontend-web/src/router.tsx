import { createBrowserRouter } from "react-router-dom";
import { MainPage as ExpertMain } from "./page/main/view.tsx";
import NotFoundPage from "./page/not-found/view.tsx";
import { LoginPage as ExpertLogin } from "./page/login/view.tsx";
import LoginMainPage from "./components/login/main/view.tsx";
import TermsPage from "./components/login/terms/view.tsx";

import PatientListPage from "./components/main/patient-list/view.tsx";
import { DashboardPage as ExpertDashboard } from "./components/main/dashboard/view.tsx";
import PatientPage from "./components/main/patient/view.tsx";

import SocialLoginFailurePage from "./components/login/social-login-failure/view.tsx";
import { RegisterPage as ExpertFacilityRegistration } from "./components/main/register/view.tsx";
import MyPage from "./components/main/mypage/view.tsx";
import SocialLogin from "./components/login/social-login/view.tsx";
import LoadingPage from "./page/loading/view.tsx";
import IdentifyPage from "./components/login/identify/view.tsx";
import IdentifyFailurePage from "./components/login/identify-failure/view.tsx";
import CertifyPage from "./components/main/certify/view.tsx";
import IdentifySuccessPage from "./components/login/identify-success/view.tsx";
import RegisterSuccessPage from "./components/main/register-success/view.tsx";
import RegisterFailurePage from "./components/main/register-failure/view.tsx";
import CertificationSuccess from "./components/main/certify-success/view.tsx";
import CertifyFailurePage from "./components/main/certify-failure/view.tsx";
import SocialLoginNotYetPage from "./components/login/social-login-not-yet/view.tsx";
import AdminLogin from "./page/admin-login/view.tsx";
import AdminMain from "@page/admin-main/view.tsx";

export const EXPERT_HOME = "/expert";
export const EXPERT_LOGIN_ROUTE = "/expert/login";
export const ADMIN_LOGIN_ROUTE = "/admin-login/login";

export const router = createBrowserRouter([
  {
    errorElement: <NotFoundPage />,
    children: [
      {
        path: "/expert",
        element: <ExpertMain />,
        errorElement: <NotFoundPage />,
        children: [
          {
            errorElement: <NotFoundPage />,
            children: [
              {
                index: true,
                element: <ExpertDashboard />,
              },
              {
                path: "info",
                element: <MyPage />,
              },
              {
                path: "patient",
                element: <PatientListPage />,
              },
              {
                path: "registration",
                element: <ExpertFacilityRegistration />,
              },
              {
                path: "registration/success",
                element: <RegisterSuccessPage />,
              },
              {
                path: "registration/failure",
                element: <RegisterFailurePage />,
              },
              {
                path: "certification/success",
                element: <CertificationSuccess />,
              },
              {
                path: "certification/failure",
                element: <CertifyFailurePage />,
              },
              {
                path: "certification",
                element: <CertifyPage />,
              },
              {
                path: "patient/:patientId",
                element: <PatientPage />,
              },
            ],
          },
        ],
      },
      {
        path: "/admin",
        element: <AdminLogin />,
      },
      {
        path: "/admin/main",
        element: <AdminMain />,
      },
      {
        path: "",
        element: <ExpertLogin />,
        errorElement: <NotFoundPage />,
        children: [
          {
            errorElement: <NotFoundPage />,
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
                path: "social/not-yet",
                element: <SocialLoginNotYetPage />,
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
        errorElement: <NotFoundPage />,
      },
    ],
  },
]);
