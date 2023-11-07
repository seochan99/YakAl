import * as S from "./style.ts";
import Header from "@layout/header/view.tsx";
import Footer from "@layout/footer/view.tsx";
import { Outlet } from "react-router-dom";
import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHotelOutlinedIcon from "@mui/icons-material/LocalHotelOutlined";

function AdminMain() {
  const navList = [
    { path: "/admin", name: "유저 관리", icon: DashboardOutlinedIcon },
    { path: `/admin/statics/dose`, name: "약 통계", icon: LocalHotelOutlinedIcon },
    { path: `/admin/statics/compliance`, name: "복약 순응도", icon: LocalHotelOutlinedIcon },
  ];

  return (
    <S.OuterDiv>
      <Header to={"/admin/main"} isAdmin={true}>
        <S.NavOuterDiv>
          {navList.map((navItem) => (
            <S.ItemNavLink
              key={navItem.path + "_" + navItem.name}
              to={navItem.path}
              end={navItem.path === "/expert"}
              className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
            >
              {navItem.name}
            </S.ItemNavLink>
          ))}
        </S.NavOuterDiv>
      </Header>
      <S.CenteringMain>
        <Outlet />
      </S.CenteringMain>
      <Footer />
    </S.OuterDiv>
  );
}

export default AdminMain;
