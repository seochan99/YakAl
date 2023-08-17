import { ComponentType } from "react";
import { SvgIconComponent } from "@mui/icons-material";

import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHospitalOutlinedIcon from "@mui/icons-material/LocalHospitalOutlined";
import AssistWalkerOutlinedIcon from "@mui/icons-material/AssistWalkerOutlined";
import Groups2OutlinedIcon from "@mui/icons-material/Groups2Outlined";

import Facility from "@/page/main/facility";
import Patient from "@/page/main/patient";
import Cohort from "@/page/main/cohort";
import Dashboard from "@/page/main/dashboard";

export type RouterType = {
  path: string;
  icon: SvgIconComponent;
  korName: string;
  element: ComponentType;
};

export const sidebarRouterMap: RouterType[] = [
  { path: "", icon: DashboardOutlinedIcon, korName: "대시보드", element: Dashboard },
  {
    path: "facility",
    icon: LocalHospitalOutlinedIcon,
    korName: "약국/병원 관리",
    element: Facility,
  },
  {
    path: "patient",
    icon: AssistWalkerOutlinedIcon,
    korName: "환자 정보",
    element: Patient,
  },
  {
    path: "cohort",
    icon: Groups2OutlinedIcon,
    korName: "코호트 연구 체크리스트",
    element: Cohort,
  },
];
