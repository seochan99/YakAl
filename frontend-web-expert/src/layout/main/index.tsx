import {
  Detail,
  Outer,
  MainSection,
  NavOuter,
  NavItem,
  MobileNavOuter,
  MobileNavTitle,
  MobileNavItem,
  MobileNavList,
  DrawableList,
  MobileCurrentNav,
} from "@/layout/main/style";
import { Outlet, useLocation, useNavigation } from "react-router-dom";
import { useMediaQuery } from "react-responsive";

import Footer from "@/layout/footer";
import Header from "../header";
import Profile from "@/layout/main/child/profile";
import { MAIN_DASHBOARD_ROUTE } from "@/router/router";
// import { useGetUserQuery } from "@/api/user";
// import ErrorPage from "@/page/error-page";
// import LoadingPage from "@/page/loading-page";
import { useState } from "react";

import KeyboardArrowDownIcon from "@mui/icons-material/KeyboardArrowDown";
import DashboardOutlinedIcon from "@mui/icons-material/DashboardOutlined";
import LocalHotelOutlinedIcon from "@mui/icons-material/LocalHotelOutlined";
import AssignmentIndOutlinedIcon from "@mui/icons-material/AssignmentIndOutlined";

export default function Main() {
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  const navigation = useNavigation();
  const location = useLocation();

  const navRouter = [
    { path: "/", name: "대시보드", icon: DashboardOutlinedIcon },
    { path: "/patient", name: "환자 목록", icon: LocalHotelOutlinedIcon },
    { path: "/info", name: "내 정보", icon: AssignmentIndOutlinedIcon },
  ];

  const data = {
    name: "홍길동",
  };

  // const { data, isLoading, isError } = useGetUserQuery(null);

  // if (isLoading || !data) {
  //   return <LoadingPage />;
  // }

  // if (isError) {
  //   return <ErrorPage />;
  // }

  const currentNavItem = navRouter.findLast((navItem) => location.pathname.slice(1).startsWith(navItem.path.slice(1)));

  return (
    <Outer>
      <Header to={MAIN_DASHBOARD_ROUTE}>
        {!isWideMobile && (
          <NavOuter>
            {navRouter.map((itemRouter) => (
              <NavItem
                key={itemRouter.path + "_" + itemRouter.name}
                to={itemRouter.path}
                className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
              >
                {itemRouter.name}
              </NavItem>
            ))}
          </NavOuter>
        )}
        <Profile
          job="가정의학과 의사"
          name={data?.name ? data?.name : ""}
          imgSrc="https://mui.com/static/images/avatar/1.jpg"
        />
      </Header>
      {isWideMobile && (
        <MobileNavOuter>
          <MobileNavTitle onClick={() => setIsOpen(!isOpen)} className={isOpen ? "open" : ""}>
            {currentNavItem ? (
              <MobileCurrentNav>
                <currentNavItem.icon />
                {currentNavItem.name}
              </MobileCurrentNav>
            ) : null}
            <KeyboardArrowDownIcon />
          </MobileNavTitle>
          <DrawableList className={isOpen ? "open" : ""}>
            <MobileNavList className={isOpen ? "open" : ""}>
              {navRouter.map((itemRouter) => (
                <MobileNavItem
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
