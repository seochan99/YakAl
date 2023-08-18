import { theme } from "@/style/theme";
import { Link } from "react-router-dom";
import styled, { keyframes } from "styled-components";

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
    justify-content: center;
    padding-left: 2rem;
    padding-right: 1rem;
    height: 100%;
  }
  &:after {
    content: "";
    position: absolute;
    top: 2rem;
    bottom: 2rem;
    left: 0;
    width: 1px;
    border-left: 1px solid ${theme.colors.gray[300]};
  }
`;

export const Job = styled.span`
  font-size: 0.9rem;
  line-height: 1.2rem;
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
    margin-top: 0.3rem;
  }
  &:hover {
    color: ${theme.colors.indigo[600]};
    transition: color ease 0.2s;
    cursor: pointer;
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
  line-height: 1.8rem;
  font-weight: 600;
  margin-top: 0.2rem;
  text-align: right;
`;

export const ProfileMenu = styled.div`
  & {
    display: flex;
    flex-direction: column;
    position: absolute;
    top: 6rem;
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
    padding: 0.5rem;
    line-height: 1rem;
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
  background: #e9e9ee;
  margin: 0.8rem 0;
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
    margin: 0 0.8rem;
  }
  &:hover {
    background-color: ${theme.colors.mojo[700]};
  }
`;
