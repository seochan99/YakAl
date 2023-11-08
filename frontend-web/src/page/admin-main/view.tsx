import * as S from "./style.ts";
import Header from "@layout/header/view.tsx";
import Footer from "@layout/footer/view.tsx";
import { Outlet, useNavigate } from "react-router-dom";
import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHotelOutlinedIcon from "@mui/icons-material/LocalHotelOutlined";
import { useEffect } from "react";
import { Cookies } from "react-cookie";
import { authAxios } from "@api/auth/instance.ts";
import { logout } from "@api/auth/auth.ts";
import { ExpertUserViewModel } from "@page/main/view.model.ts";

function AdminMain() {
  const navList = [
    { path: "/admin", name: "유저 관리", icon: DashboardOutlinedIcon },
    { path: `/admin/statics/dose`, name: "약 통계", icon: LocalHotelOutlinedIcon },
    { path: `/admin/statics/compliance`, name: "복약 순응도", icon: LocalHotelOutlinedIcon },
  ];

  const navigate = useNavigate();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");
    cookies.remove("accessToken", { path: "/" });
    authAxios.defaults.headers.common["Authorization"] = `Bearer ${accessToken}`;

    ExpertUserViewModel.fetch();
  }, [navigate]);

  return (
    <S.OuterDiv>
      <Header to={"/admin"} isAdmin={true}>
        <S.NavOuterDiv>
          {navList.map((navItem) => (
            <S.ItemNavLink
              key={navItem.path + "_" + navItem.name}
              to={navItem.path}
              end={navItem.path === "/admin"}
              className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
            >
              {navItem.name}
            </S.ItemNavLink>
          ))}
        </S.NavOuterDiv>
        <S.NavOuterDiv>
          <S.LogoutButton
            onClick={() => {
              logout().then(() => {
                window.location.href = "/";
              });
            }}
          >
            {"로그아웃"}
          </S.LogoutButton>
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
