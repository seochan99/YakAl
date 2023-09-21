import {
  Detail,
  DrawableList,
  MainSection,
  MobileCurrentNav,
  MobileNavItem,
  MobileNavList,
  MobileNavOuter,
  MobileNavTitle,
  NavItem,
  NavOuter,
  Outer,
} from "./style.ts";
import { Outlet, useLocation, useNavigation } from "react-router-dom";
import { useMediaQuery } from "react-responsive";

import Footer from "../../layout/footer/view.tsx";
import Header from "../../layout/header/view.tsx";
import Profile from "./children/profile";
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
    <Outer>
      <Header to="/expert">
        {!isWideMobile && (
          <NavOuter>
            {navRouter.map((itemRouter) => (
              <NavItem
                key={itemRouter.path + "_" + itemRouter.name}
                to={itemRouter.path}
                end={itemRouter.path === "/expert"}
                className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
              >
                {itemRouter.name}
              </NavItem>
            ))}
          </NavOuter>
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
        <MobileNavOuter>
          <MobileNavTitle onClick={() => setIsOpen(!isOpen)} className={isOpen ? "open" : ""}>
            <MobileCurrentNav>
              <currentNavItem.icon />
              {currentNavItem.name}
            </MobileCurrentNav>
            <KeyboardArrowDownIcon />
          </MobileNavTitle>
          <DrawableList className={isOpen ? "open" : ""}>
            <MobileNavList className={isOpen ? "open" : ""}>
              {navRouter.map((itemRouter) => (
                <MobileNavItem
                  end={itemRouter.path === "/expert"}
                  key={itemRouter.path + "_" + itemRouter.name}
                  to={itemRouter.path}
                  onClick={() => setIsOpen(false)}
                  className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
                >
                  <itemRouter.icon />
                  {itemRouter.name}
                </MobileNavItem>
              ))}
            </MobileNavList>
          </DrawableList>
        </MobileNavOuter>
      )}
      <MainSection>
        <Detail className={navigation.state === "loading" ? "loading" : ""}>
          <Outlet />
        </Detail>
      </MainSection>
      <Footer />
    </Outer>
  );
}
