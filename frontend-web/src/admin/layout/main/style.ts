import { styled } from "styled-components";
import { Link, NavLink } from "react-router-dom";
import { Drawer } from "@mui/material";

export const Outer = styled.div`
  --drawer-width-open: 15;
  --drawer-width-close: 6;
  --drawer-z-index: 100;
  --drawer-transition: all ease-in-out 0.3s;

  display: flex;
  flex-direction: column;
  width: 100%;
  min-height: 100vh;
  min-height: -webkit-fill-available;
`;

export const HeaderOuter = styled.header`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    align-self: flex-start;
    height: 5rem;
    line-height: 5rem;
    box-sizing: border-box;
    background-color: var(--color-surface-200);
    z-index: calc(var(--drawer-z-index) + 1);
  }

  &.close {
    width: 100%;
    transition: var(--drawer-transition);
  }

  &.open {
    width: calc(100% - var(--drawer-width-open) * 1rem);
    transition: var(--drawer-transition);
  }
`;

export const LinkLogo = styled(Link)`
  position: relative;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 5rem;
  padding: 0 3rem;
  gap: 1rem;
  text-decoration: none;
`;

export const YakalIcon = styled.img`
  content: url("/src/global/asset/yakal-logo.png");
  width: 3rem;
`;

export const LogoText = styled.div`
  display: flex;
  align-items: center;
  flex-direction: row;
  gap: 1rem;
`;

export const Title = styled.span`
  text-align: center;
  font-weight: 700;
  color: #fff;
  font-size: 1.6rem;
  line-height: 1.6rem;
`;

export const Subtitle = styled.span`
  font-size: 1.1rem;
  font-weight: 600;
  line-height: 1.1rem;
  color: var(--color-primary-500);
`;

export const HamburgerWrapper = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    width: calc(var(--drawer-width-close) * 1rem);
    align-self: stretch;
  }

  & .hamburger-react div {
    color: #fff;
  }
`;

export const MainSection = styled.main`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  align-self: flex-start;
  flex: 1;

  @media only screen and (min-width: 481px) {
    & {
      background-color: var(--color-surface-150);
    }

    &.close {
      width: calc(100% - var(--drawer-width-close) * 1rem);
      transition: var(--drawer-transition);
    }

    &.open {
      width: calc(100% - var(--drawer-width-open) * 1rem);
      transition: var(--drawer-transition);
    }
  }

  @media only screen and (max-width: 480px) {
    background-color: var(--color-surface-300);
  }
`;

export const Detail = styled.div`
  & {
    display: flex;
    flex-direction: column;

    @media only screen and (min-width: 769px) {
      width: 54rem;
      padding: 2rem;
    }

    @media only screen and (max-width: 768px) {
      width: 100%;
      padding: 0;
    }
  }

  &.loading {
    opacity: 0.25;
    transition: opacity 200ms;
    transition-delay: 200ms;
  }
`;

export const StyledDrawer = styled(Drawer)`
  & {
    z-index: var(--drawer-z-index);
  }

  & .MuiPaper-root {
    border: 0;
  }
`;

export const DrawerBox = styled.div`
  --drawer-box-padding: 1;

  display: flex;
  flex-direction: column;
  background-color: var(--color-surface-300);
  padding: 0 calc(var(--drawer-box-padding) * 1rem);
  min-height: 100vh;
  min-height: -webkit-fill-available;

  &.close {
    width: calc(var(--drawer-width-close) * 1rem - var(--drawer-box-padding) * 1rem * 2);
    transition: var(--drawer-transition);
  }

  &.open {
    width: calc(var(--drawer-width-open) * 1rem - var(--drawer-box-padding) * 1rem * 2);
    transition: var(--drawer-transition);
  }

  & * {
    overflow-x: hidden;
    white-space: nowrap;
  }
`;

export const DrawerHeader = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  height: 5rem;
  gap: 0.4rem;
`;

export const DrawerTitle = styled.span`
  color: #fff;
  font-size: 1.2rem;
  font-weight: 500;
  line-height: 1.2rem;
  min-height: 1.4rem;
`;

export const PrimarySpan = styled.span`
  color: var(--color-primary-600);
`;

export const DrawerSubtitle = styled.span`
  color: #fff;
  font-size: 0.9rem;
  font-weight: 400;
  line-height: 0.9rem;
  min-height: 1rem;
`;

export const Bar = styled.hr`
  border: 0;
  height: 0.1rem;
  background: #fff;
  margin: 0;
`;

export const List = styled.div`
  display: flex;
  flex-direction: column;
  gap: 0.3rem;
  margin: 1rem 0;
  overflow-y: auto;
  flex: 1;

  &.open {
    align-items: stretch;
  }

  &.close {
    align-items: center;
  }
`;

export const ListItemSubtitle = styled.span`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    color: var(--color-primary-500);
    font-size: 0.9rem;
    font-weight: 700;
    line-height: 0.9rem;
    min-height: 1rem;
    margin: 0.4rem 0;
    padding: 0.3rem 0;
    border-radius: 0.25rem;
    gap: 0.2rem;
  }

  & svg {
    height: 0.9rem;
  }
`;

export const ListItem = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 0.4rem 0.6rem;
    color: #fff;
    font-size: 0.9rem;
    font-weight: 500;
    line-height: 0.9rem;
    min-height: 1.6rem;
    border-radius: 0.25rem;
    text-decoration: none;
    gap: 0.6rem;
  }

  & svg {
    height: 1.2rem;
  }

  &:hover {
    color: var(--color-primary-200);
    background-color: #f5f5f9;
    transition: color 0.2s;
  }

  &.active {
    background-color: #e9e9ee;
  }
`;

export const DrawerFooter = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 5rem;
`;

export const LogoutButton = styled.button`
  & {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0.65rem 2.25rem;
    border: 0;
    border-radius: 0.25rem;
    font-size: 0.9rem;
    line-height: 0.9rem;
    font-weight: 600;
    color: #fff;
    background-color: var(--red-500);
  }

  &:hover {
    background-color: var(--red-600);
    cursor: pointer;
  }

  &:active {
    background-color: var(--red-700);
  }
`;
