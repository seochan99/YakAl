import * as S from "./style.ts";
import { Outlet, useLocation, useNavigation } from "react-router-dom";
import { useMediaQuery } from "react-responsive";

import Footer from "../../layout/footer/view.tsx";
import Header from "../../layout/header/view.tsx";
import Profile from "./children/profile/view.tsx";
import { useState } from "react";

import KeyboardArrowDownIcon from "@mui/icons-material/KeyboardArrowDown";
import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHotelOutlinedIcon from "@mui/icons-material/LocalHotelOutlined";
import AssignmentIndOutlinedIcon from "@mui/icons-material/AssignmentIndOutlined";
import { EJob } from "../../type/job.ts";

export function MainPage() {
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  const navigation = useNavigation();
  const location = useLocation();

  const navRouter = [
    { path: "/expert", name: "대시보드", icon: DashboardOutlinedIcon },
    { path: "/expert/patient", name: "환자 목록", icon: LocalHotelOutlinedIcon },
    { path: "/expert/info", name: "내 정보", icon: AssignmentIndOutlinedIcon },
  ];

  const currentNavItem = navRouter.findLast((navItem) => location.pathname.startsWith(navItem.path));

  return (
    <S.OuterDiv>
      <Header to="/expert">
        {!isWideMobile && (
          <S.NavOuterDiv>
            {navRouter.map((itemRouter) => (
              <S.ItemNavLink
                key={itemRouter.path + "_" + itemRouter.name}
                to={itemRouter.path}
                end={itemRouter.path === "/expert"}
                className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
              >
                {itemRouter.name}
              </S.ItemNavLink>
            ))}
          </S.NavOuterDiv>
        )}
        <Profile
          job={EJob.DOCTOR}
          department={"가정의학과"}
          belong={"중앙대학교 부속병원"}
          name={"홍길동"}
          imgSrc="https://mui.com/static/images/avatar/1.jpg"
        />
      </Header>
      {isWideMobile && currentNavItem && (
        <S.MobileNavOuterDiv>
          <S.MobileTitleDiv onClick={() => setIsOpen(!isOpen)} className={isOpen ? "open" : ""}>
            <S.MobileCurrentNavDiv>
              <currentNavItem.icon />
              {currentNavItem.name}
            </S.MobileCurrentNavDiv>
            <KeyboardArrowDownIcon />
          </S.MobileTitleDiv>
          <S.DrawableListDiv className={isOpen ? "open" : ""}>
            <S.MobileNavListDiv className={isOpen ? "open" : ""}>
              {navRouter.map((itemRouter) => (
                <S.MobileItemNavLink
                  end={itemRouter.path === "/expert"}
                  key={itemRouter.path + "_" + itemRouter.name}
                  to={itemRouter.path}
                  onClick={() => setIsOpen(false)}
                  className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
                >
                  <itemRouter.icon />
                  {itemRouter.name}
                </S.MobileItemNavLink>
              ))}
            </S.MobileNavListDiv>
          </S.DrawableListDiv>
        </S.MobileNavOuterDiv>
      )}
      <S.MainDiv>
        <S.DetailDiv className={navigation.state === "loading" ? "loading" : ""}>
          <Outlet />
        </S.DetailDiv>
      </S.MainDiv>
      <Footer />
    </S.OuterDiv>
  );
}
