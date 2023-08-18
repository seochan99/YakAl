import { theme } from "@/style/theme";
import { NavLink } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    height: 3rem;
    border: 0;
    border-radius: 0.25rem;
    margin: 0.5rem 0;
    text-decoration: none;
  }
  &:hover {
    cursor: pointer;
    background-color: #e9e9ee;
  }
  &.active {
    background-color: ${theme.colors.indigo[500]};
  }
  &.active span {
    color: #fff;
  }
  &.pending {
    background-color: #e9e9ee;
  }
`;

export const NameSex = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  margin-left: 1rem;
`;

export const Name = styled.span`
  color: #151515;
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.25rem;
  margin-right: 0.4rem;
`;

export const Sex = styled.span`
  color: #151515;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
`;

export const Birthday = styled.span`
  color: #151515;
  text-align: right;
  font-size: 1rem;
  font-weight: 500;
  line-height: 1rem;
  margin-right: 1rem;
`;
