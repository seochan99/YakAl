import { theme } from "@/style/theme";
import { NavLink } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled(NavLink)`
  & {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    height: 3.8rem;
    border: 0;
    border-radius: 0.25rem;
    margin: 0.2rem 0;
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
  font-size: 1.15rem;
  font-weight: 600;
  line-height: 1.25rem;
  margin-right: 0.4rem;
`;

export const Sex = styled.span`
  color: #151515;
  font-size: 0.95rem;
  font-weight: 500;
  line-height: 0.95rem;
`;

export const Birthday = styled.span`
  color: #151515;
  text-align: right;
  font-size: 0.95rem;
  font-weight: 500;
  line-height: 0.95rem;
  margin-right: 1rem;
`;
