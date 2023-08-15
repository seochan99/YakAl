import {
  Detail,
  Sidebar,
  Item,
  Nav,
  TopRight,
  Ul,
  ItemName,
  Screen,
  Topbar,
  NonTopSection,
  SwingIconButton,
  ProfileImg,
  ProfileText,
  Job,
  NameBox,
  Name,
  ButtonBox,
  ProfileMenu,
  Logout,
  ProfileMenuItem,
  Bar,
} from "@/layout/root/style";
import { Outlet, useNavigate, useNavigation } from "react-router-dom";
import { routerMap } from "@/router/router-map";

import PersonOutlineOutlinedIcon from "@mui/icons-material/PersonOutlineOutlined";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { useEffect, useRef, useState } from "react";
import Logo from "@/layout/logo";

export default function Root() {
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isFirst, setIsFirst] = useState<boolean>(true);

  const profileMenuRef = useRef<HTMLDivElement>(null);

  const navigation = useNavigation();
  const navigate = useNavigate();

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (profileMenuRef.current) {
        if (!(e.target instanceof Node) || !profileMenuRef.current.contains(e.target)) {
          if (isOpen) {
            setTimeout(() => setIsOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [isOpen]);

  return (
    <Screen>
      <Topbar>
        <Logo hasBorder={true} />
        <TopRight>
          <ButtonBox>
            <SwingIconButton>
              <NotificationsNoneOutlinedIcon />
            </SwingIconButton>
          </ButtonBox>
          <ProfileText>
            <Job>가정의학과 의사</Job>
            <NameBox
              className={isFirst ? "" : isOpen ? "open" : "close"}
              onClick={() => {
                setIsOpen(true);
                setIsFirst(false);
              }}
            >
              <Name>박하늘별님구름햇님보다사랑스러우리</Name>
              <ArrowDropDownIcon />
            </NameBox>
          </ProfileText>
          <ProfileImg src="https://mui.com/static/images/avatar/1.jpg" />
        </TopRight>
      </Topbar>
      {isOpen && (
        <ProfileMenu ref={profileMenuRef}>
          <ProfileMenuItem to="/">
            <PersonOutlineOutlinedIcon />
            <span>내 정보</span>
          </ProfileMenuItem>
          <Bar />
          <Logout>로그아웃</Logout>
        </ProfileMenu>
      )}
      <NonTopSection>
        <Sidebar>
          <Nav>
            <Ul>
              {routerMap.map((router) => (
                <li key={router.path}>
                  <Item
                    to={router.path}
                    className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
                  >
                    <router.icon />
                    <ItemName>{router.korName}</ItemName>
                  </Item>
                </li>
              ))}
            </Ul>
          </Nav>
        </Sidebar>
        <Detail className={navigation.state === "loading" ? "loading" : ""}>
          <Outlet />
        </Detail>
      </NonTopSection>
    </Screen>
  );
}
