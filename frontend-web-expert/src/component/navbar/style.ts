import { theme } from "@/style/theme";
import { Badge, IconButton } from "@mui/material";
import { Link, NavLink } from "react-router-dom";
import styled, { keyframes } from "styled-components";

const swing = keyframes`
  0%,
  30%,
  50%,
  70%,
  100% {
    transform: rotate(0deg);
  }
  10% {
    transform: rotate(10deg);
  }
  40% {
    transform: rotate(-10deg);
  }
  60% {
    transform: rotate(5deg);
  }
  80% {
    transform: rotate(-5deg);
  }
`;

export const NavOuter = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
`;

export const TextNav = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.6rem;
  padding: 0 1rem;
`;

export const SwingIconButton = styled(IconButton)`
  & {
    padding: 0 2rem;
  }
  &:hover {
    color: ${theme.colors.indigo[500]};
  }
  &:hover svg {
    animation: ${swing} ease-in-out 0.5s 1 alternate;
  }
`;

export const SmallBadge = styled(Badge)`
  & .MuiBadge-badge {
    border: 2px solid white;
    font-size: 0.2rem;
  }
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
    transition: color 0.2s;
  }
  &.active {
    background-color: #e9e9ee;
  }
`;

export const IconNav = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 1rem;
  padding: 0 1rem;
  border-left: 1px solid #a4a7b6;
  border-right: 1px solid #a4a7b6;
`;

export const ProfileMenu = styled.div`
  & {
    display: flex;
    flex-direction: column;
    position: absolute;
    top: 6rem;
    right: 13.9rem;
    width: 8rem;
    padding: 0.8rem;
    border-radius: 0.6rem;
    background-color: white;
    border: 1px solid #dedfe5;
  }
  &:before {
    content: "";
    position: absolute;
    top: -0.6rem;
    right: 4rem;
    width: 1rem;
    height: 1rem;
    transform: rotate(45deg);
    background-color: white;
    border-left: 1px solid #dedfe5;
    border-top: 1px solid #dedfe5;
  }
`;

export const ProfileMenuItem = styled(Link)`
  & {
    display: flex;
    flex-direction: row;
    font-size: 0.9rem;
    text-decoration: none;
    color: black;
    border-radius: 0.2rem;
    padding: 0.5rem;
    line-height: 1rem;
  }
  &:hover {
    background-color: ${theme.colors.gray[200]};
  }
`;
