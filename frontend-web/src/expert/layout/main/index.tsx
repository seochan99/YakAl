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

import Footer from "../footer";
import Header from "../header";
import Profile from "../../../expert/layout/main/child/profile";
import { useState } from "react";

import KeyboardArrowDownIcon from "@mui/icons-material/KeyboardArrowDown";
import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHotelOutlinedIcon from "@mui/icons-material/LocalHotelOutlined";
import AssignmentIndOutlinedIcon from "@mui/icons-material/AssignmentIndOutlined";
import ErrorPage from "../../../expert/page/error-page";
import LoadingPage from "../../../expert/page/loading-page";
import { useGetUserQuery } from "../../api/user.ts";

export function Main() {
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  const navigation = useNavigation();
  const location = useLocation();

  const navRouter = [
    { path: "/expert", name: "대시보드", icon: DashboardOutlinedIcon },
    { path: "/expert/patient", name: "환자 목록", icon: LocalHotelOutlinedIcon },
    { path: "/expert/info", name: "내 정보", icon: AssignmentIndOutlinedIcon },
  ];

  const { data, isLoading, isError } = useGetUserQuery(null);

  if (isLoading) {
    return <LoadingPage />;
  }

  if (isError) {
    return <ErrorPage />;
  }

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
          job={data?.job}
          department={data?.department}
          belong={"중앙대학교 부속병원"}
          name={data?.name ? data?.name : ""}
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
