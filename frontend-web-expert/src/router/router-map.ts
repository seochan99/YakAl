import { RouterType } from "./router-map-type";

import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHospitalOutlinedIcon from "@mui/icons-material/LocalHospitalOutlined";
import AssistWalkerOutlinedIcon from "@mui/icons-material/AssistWalkerOutlined";
import Groups2OutlinedIcon from "@mui/icons-material/Groups2Outlined";
import Dashboard from "@/page/dashboard";
import Facility from "@/page/facility";
import Patient from "@/page/patient";
import Cohort from "@/page/cohort";

export const routerMap: RouterType[] = [
  { path: "/", icon: DashboardOutlinedIcon, korName: "대시보드", engName: "Dashboard", element: Dashboard },
  {
    path: "/facility",
    icon: LocalHospitalOutlinedIcon,
    korName: "약국/병원 관리",
    engName: "Pharmacy/Hospital Management",
    element: Facility,
  },
  {
    path: "/patient",
    icon: AssistWalkerOutlinedIcon,
    korName: "환자 정보",
    engName: "Patient Information",
    element: Patient,
  },
  {
    path: "/cohort",
    icon: Groups2OutlinedIcon,
    korName: "코호트 연구 체크리스트",
    engName: "Cohort Study Checklist",
    element: Cohort,
  },
];
