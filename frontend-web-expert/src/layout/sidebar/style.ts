import { theme } from "@/style/theme";
import { NavLink } from "react-router-dom";
import styled from "styled-components";

export const Outer = styled.aside`
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
