import { createBrowserRouter } from "react-router-dom";
import { MainPage as ExpertMain } from "@page/main/view.tsx";
import NotFoundPage from "@page/not-found/view.tsx";
import { LoginPage as ExpertLogin } from "@page/login/view.tsx";
import LoginMainPage from "@components/login/main/view.tsx";
import TermsPage from "@components/login/terms/view.tsx";

import PatientListPage from "@components/main/patient-list/view.tsx";
import { DashboardPage as ExpertDashboard } from "@components/main/dashboard/view.tsx";
import PatientPage from "@components/main/patient/view.tsx";

import SocialLoginFailurePage from "@components/login/social-login-failure/view.tsx";
import { RegistrationPage as ExpertFacilityRegistration } from "@components/main/registration/view.tsx";
import MyPage from "@components/main/mypage/view.tsx";
import AfterSocialLoginPage from "@components/login/after-social-login/view.tsx";
import IdentifyPage from "@components/login/identify/view.tsx";
import IdentifyResultPage from "@components/login/identify-result/view.tsx";
import CertificationPage from "@components/main/certification/view.tsx";
import RegistrationResultPage from "@components/main/registration-result/view.tsx";
import CertificationResultPage from "@components/main/certification-result/view.tsx";
import SocialLoginNotYetPage from "@components/login/social-login-not-yet/view.tsx";
import AdminMain from "@page/admin-main/view.tsx";
import AdminExpertDetail from "@components/admin-main/expert-detail/view.tsx";
import { loader as adminExpertDetailLoader } from "@components/admin-main/expert-detail/loader.ts";
import { loader as adminFacilityDetailLoader } from "@components/admin-main/facility-detail/loader.ts";
import AdminApprovalList from "@components/admin-main/approval-list/view.tsx";
import AdminFacilityDetail from "@components/admin-main/facility-detail/view.tsx";

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
                path: "registration/result",
                element: <RegistrationResultPage />,
              },
              {
                path: "certification/result",
                element: <CertificationResultPage />,
              },
              {
                path: "certification",
                element: <CertificationPage />,
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
        element: <AdminMain />,
        errorElement: <NotFoundPage />,
        children: [
          {
            path: "",
            element: <AdminApprovalList />,
          },
          {
            path: "expert/:expertId",
            element: <AdminExpertDetail />,
            loader: adminExpertDetailLoader,
          },
          {
            path: "facility/:facilityId",
            element: <AdminFacilityDetail />,
            loader: adminFacilityDetailLoader,
          },
        ],
      },
      {
        path: "login/social",
        element: <AfterSocialLoginPage />,
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
                path: "login/terms",
                element: <TermsPage />,
              },
              {
                path: "login/social/failure",
                element: <SocialLoginFailurePage />,
              },
              {
                path: "login/social/not-yet",
                element: <SocialLoginNotYetPage />,
              },
              {
                path: "login/identify",
                element: <IdentifyPage />,
              },
              {
                path: "login/identify/result",
                element: <IdentifyResultPage />,
              },
            ],
          },
        ],
      },
    ],
  },
]);
