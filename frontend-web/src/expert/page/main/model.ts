import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHotelOutlinedIcon from "@mui/icons-material/LocalHotelOutlined";
import AssignmentIndOutlinedIcon from "@mui/icons-material/AssignmentIndOutlined";
import { OverridableComponent } from "@mui/material/OverridableComponent";
import { SvgIconTypeMap } from "@mui/material/SvgIcon/SvgIcon";

type TNavItem = {
  path: string;
  name: string;
  icon: OverridableComponent<SvgIconTypeMap> & { muiName: string };
};

export class MainPageModel {
  static navList: TNavItem[] = [
    { path: "/expert", name: "대시보드", icon: DashboardOutlinedIcon },
    { path: `/expert/patient`, name: "환자 목록", icon: LocalHotelOutlinedIcon },
    { path: `/expert/info`, name: "내 정보", icon: AssignmentIndOutlinedIcon },
  ];
}
