import { ComponentType } from "react";
import { SvgIconComponent } from "@mui/icons-material";

import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHospitalOutlinedIcon from "@mui/icons-material/LocalHospitalOutlined";
import AssistWalkerOutlinedIcon from "@mui/icons-material/AssistWalkerOutlined";
import Groups2OutlinedIcon from "@mui/icons-material/Groups2Outlined";

export type RouterType = {
  path: string;
  icon: SvgIconComponent;
  korName: string;
};

export const sidebarRouterMap: RouterType[] = [
  { path: "", icon: DashboardOutlinedIcon, korName: "대시보드" },
  {
    path: "facility",
    icon: LocalHospitalOutlinedIcon,
    korName: "약국/병원 관리",
  },
  {
    path: "patient",
    icon: AssistWalkerOutlinedIcon,
    korName: "환자 정보",
  },
  {
    path: "cohort",
    icon: Groups2OutlinedIcon,
    korName: "코호트 연구 체크리스트",
  },
];
