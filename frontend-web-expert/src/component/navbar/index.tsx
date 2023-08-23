import { IconNav, NavItem, Outer, ProfileMenu, ProfileMenuItem, SmallBadge, SwingIconButton, TextNav } from "./style";

import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import LogoutOutlinedIcon from "@mui/icons-material/LogoutOutlined";
import { useEffect, useRef, useState } from "react";
import { useNavigate } from "react-router-dom";
import { LOGIN_ROUTE } from "@/router/router";
import NavbarTooltip from "./child/navbar-tooltip";
import { useLazyLogoutQuery } from "@/api/auth";
import { useDispatch } from "react-redux";
import { logout } from "@/store/auth";

function NavBar() {
  const [isOpen, setIsOpen] = useState<boolean>(false);

  const [trigger, currentResult] = useLazyLogoutQuery();

  const profileMenuRef = useRef<HTMLDivElement>(null);

  const dispatch = useDispatch();

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

  const handleLogoutClick = async () => {
    trigger(null);
  };

  useEffect(() => {
    const { isSuccess, isLoading } = currentResult;

    if (isSuccess && !isLoading) {
      dispatch(logout());
      navigate(LOGIN_ROUTE);
    }
  }, [currentResult, dispatch, navigate]);

  const notificationsLabel = (count: number) => {
    if (count === 0) {
      return "no notifications";
    }
    if (count > 99) {
      return "more than 99 notifications";
    }
    return `${count} notifications`;
  };

  return (
    <Outer>
      <TextNav>
        <NavItem to="/" className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}>
          대시보드
        </NavItem>
        <NavItem
          to="/patient"
          className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}
        >
          환자 목록
        </NavItem>
        <NavItem to="/info" className={({ isActive, isPending }) => (isActive ? "active" : isPending ? "pending" : "")}>
          내 정보
        </NavItem>
      </TextNav>
      <IconNav>
        <NavbarTooltip title="알림">
          <SwingIconButton
            aria-label={notificationsLabel(1)}
            onClick={() => {
              setIsOpen(true);
            }}
          >
            <SmallBadge
              badgeContent={1}
              color="error"
              max={99}
              anchorOrigin={{
                vertical: "bottom",
                horizontal: "right",
              }}
            >
              <NotificationsNoneOutlinedIcon />
            </SmallBadge>
          </SwingIconButton>
        </NavbarTooltip>
        <NavbarTooltip title="로그아웃">
          <SwingIconButton onClick={handleLogoutClick}>
            <LogoutOutlinedIcon />
          </SwingIconButton>
        </NavbarTooltip>
      </IconNav>
      {isOpen && (
        <ProfileMenu ref={profileMenuRef}>
          <ProfileMenuItem to="/">
            <span>알림 1</span>
          </ProfileMenuItem>
          <ProfileMenuItem to="/">
            <span>알림 2</span>
          </ProfileMenuItem>
          <ProfileMenuItem to="/">
            <span>알림 3</span>
          </ProfileMenuItem>
          <ProfileMenuItem to="/">
            <span>알림 4</span>
          </ProfileMenuItem>
        </ProfileMenu>
      )}
    </Outer>
  );
}

export default NavBar;
