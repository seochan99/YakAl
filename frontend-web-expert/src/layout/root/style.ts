import { theme } from "@/style/theme";
import { keyframes, styled } from "styled-components";
import { Link, NavLink } from "react-router-dom";
import { IconButton } from "@mui/material";

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

export const rotate = keyframes`
  100% {
    transform: rotateZ(180deg);
  }
`;

export const back = keyframes`
  0% {
    transform: rotateZ(180deg);
  }
  100% {
    transform: rotateZ(360deg);
  }
`;

export const Screen = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
`;

export const Topbar = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  height: 6rem;
`;

export const ButtonBox = styled.div`
  display: flex;
  flex-direction: row;
  padding: 0 1rem;
`;

export const SwingIconButton = styled(IconButton)`
  &:hover {
    color: ${theme.colors.indigo[500]};
  }
  &:hover svg {
    animation: ${swing} ease-in-out 0.5s 1 alternate;
  }
`;

export const NonTopSection = styled.div`
  display: flex;
  flex-direction: row;
  height: 100%;
  background-color: ${theme.colors.indigo[100]};
`;

export const Sidebar = styled.div`
  & {
    position: relative;
    width: 20rem;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
  &:after {
    content: "";
    position: absolute;
    top: 2rem;
    bottom: 2rem;
    right: 0;
    width: 1px;
    border-right: 1px solid ${theme.colors.gray[300]};
  }
  & > * {
    padding-left: 1rem;
    padding-right: 1rem;
  }
`;

export const Nav = styled.nav`
  flex: 1;
  overflow: auto;
  padding: 1.6rem 1rem;
`;

export const Ul = styled.ul`
  padding: 0;
  margin: 0;
  list-style: none;
`;

export const Item = styled(NavLink)`
  & {
    display: flex;
    align-items: center;
    overflow: hidden;

    white-space: pre;
    padding: 0.5rem 5rem 0.5rem 1.5rem;
    margin: 0.4rem 0;
    border-radius: 4px;
    color: inherit;

    text-decoration: none;
    font-size: 1.05rem;
    line-height: 2.5;
  }
  &:hover {
    background: ${theme.colors.indigo[200]};
  }
  &.active {
    background: ${theme.colors.indigo[500]};
    color: white;
  }
  &.pending {
    color: ${theme.colors.gray[200]};
  }
`;

export const ItemName = styled.span`
  margin-left: 1rem;
`;

export const TopRight = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  margin: 0;
  padding: 0 2rem;
`;

export const ProfileImg = styled.img`
  display: inline-block;
  width: 3rem;
  height: 3rem;
  border-radius: 50%;
`;

export const ProfileText = styled.div`
  & {
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: middle;
    padding-left: 2rem;
    padding-right: 1rem;
  }
  &:after {
    content: "";
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    width: 1px;
    border-left: 1px solid ${theme.colors.gray[300]};
  }
`;

export const Job = styled.span`
  font-size: 0.9rem;
  font-weight: 600;
  color: ${theme.colors.gray[300]};
  text-align: right;
`;

export const NameBox = styled.div`
  & {
    display: flex;
    flex-direction: row;
    color: black;
  }
  & svg {
    margin-top: 0.1rem;
  }
  &:hover {
    color: ${theme.colors.indigo[600]};
    transition: color ease 0.2s;
  }
  &.open {
    color: ${theme.colors.indigo[600]};
  }
  &.open svg {
    animation: ${rotate} 0.5s forwards;
  }
  &.close svg {
    animation: ${back} 0.5s forwards;
  }
`;

export const Name = styled.span`
  font-size: 1.2rem;
  font-weight: 600;
  margin-top: 0.2rem;
  text-align: right;
`;

export const ProfileMenu = styled.div`
  & {
    display: flex;
    flex-direction: column;
    position: absolute;
    top: 5rem;
    right: 3rem;
    width: 8rem;
    padding: 0.8rem;
    border-radius: 0.6rem;
    background-color: white;
    border: 1px solid ${theme.colors.gray[200]};
  }
  &:before {
    content: "";
    position: absolute;
    top: -0.6rem;
    right: 3.2rem;
    width: 1rem;
    height: 1rem;
    transform: rotate(45deg);
    background-color: white;
    border-left: 1px solid ${theme.colors.gray[200]};
    border-top: 1px solid ${theme.colors.gray[200]};
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
    padding: 0.4rem 0.4rem 0.2rem 0.6rem;
    margin: 0.1rem 0;
  }
  &:hover {
    background-color: ${theme.colors.gray[200]};
  }
  & svg {
    width: 0.9rem;
    height: 0.9rem;
  }
  & span {
    margin-left: 0.6rem;
  }
`;

export const Bar = styled.hr`
  border: 0;
  height: 1px;
  background: ${theme.colors.gray[300]};
  margin: 0.5rem 0;
`;

export const Logout = styled.button`
  & {
    background-color: ${theme.colors.mojo[600]};
    border: 0;
    border-radius: 0.3rem;
    padding: 0.4rem 0;
    color: white;
    font-size: 0.9rem;
    font-weight: 500;
    margin: 0.1rem 0.2rem 0;
  }
  &:hover {
    background-color: ${theme.colors.mojo[700]};
  }
`;

export const Detail = styled.div`
  & {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 2rem;
  }
  &.loading {
    opacity: 0.25;
    transition: opacity 200ms;
    transition-delay: 200ms;
  }
`;
