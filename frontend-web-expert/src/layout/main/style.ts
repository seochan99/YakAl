import { NavLink } from "react-router-dom";
import { styled } from "styled-components";

export const Outer = styled.div`
  display: flex;
  flex-direction: column;
  align-items: stretch;
  justify-content: start;
  width: 100vw;
`;

export const MainSection = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  flex: 1;
  width: 100%;
  background-color: #f5f5f9;
`;

export const Detail = styled.div`
  & {
    display: flex;
    flex-direction: column;
    padding: 2rem;

    @media only screen and (min-width: 769px) {
      width: 54rem;
    }

    @media only screen and (max-width: 768px) {
      width: 100%;
    }
  }
  &.loading {
    opacity: 0.25;
    transition: opacity 200ms;
    transition-delay: 200ms;
  }
`;

export const NavOuter = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 1rem;
`;

export const NavItem = styled(NavLink)`
  & {
    color: #151515;
    font-size: 1.1rem;
    font-weight: 600;
    line-height: 1.1rem;
    width: 6rem;
    padding: 0.5rem 0;
    border-radius: 0.25rem;
    text-decoration: none;
    text-align: center;
  }
  &:hover {
    color: #2666f6;
    background-color: #f5f5f9;
    transition: color 0.2s;
  }
  &.active {
    background-color: #e9e9ee;
  }
`;

export const MobileNavOuter = styled.div`
  display: flex;
  flex-direction: column;
`;

export const MobileNavTitle = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    font-size: 1.2rem;
    line-height: 1.2rem;
    font-weight: 700;
    color: #151515;
    border-top: 0.0625rem solid #e9e9ee;
    border-bottom: 0.0625rem solid #e9e9ee;
    background-color: #fff;
  }
  &:hover {
    cursor: pointer;
  }
  & > svg {
    opacity: 0.5;
    transform: rotate(0deg);
    transition: 0.2s;
  }
  &.open > svg {
    opacity: 1;
    transform: rotate(180deg);
  }
`;

export const DrawableList = styled.div`
  & {
    overflow: hidden;
    background-color: transparent;
    height: 0;
    transition: all 0.3s ease-out;
  }
  &.open {
    height: 9.5rem;
  }
`;

export const MobileNavList = styled.div`
  & {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
    padding: 0.4rem 1rem;
    visibility: hidden;
    transform: translateY(-100%);
    transition: all 0.3s ease-out;
    background-color: #fff;
  }
  &.open {
    visibility: visible;
    transform: translateY(0%);
    transition: all 0.3s ease-out;
  }
`;

export const MobileCurrentNav = styled.div`
  & {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }
  & svg {
    margin-right: 0.6rem;
    height: 1.2rem;
  }
`;

export const MobileNavItem = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    align-items: center;
    padding: 0.8rem 1rem;
    font-size: 1.1rem;
    line-height: 1.1rem;
    font-weight: 500;
    color: #151515;
    text-decoration: none;
    border-radius: 0.25rem;
  }
  & svg {
    height: 1.1rem;
    margin-right: 0.6rem;
  }
  &:hover {
    cursor: pointer;
    color: #2666f6;
    background-color: #f5f5f9;
    transition: color 0.2s;
  }
  &.active {
    background-color: #e9e9ee;
  }
`;
